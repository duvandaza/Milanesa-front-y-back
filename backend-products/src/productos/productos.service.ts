import { BadRequestException, HttpException, HttpStatus, Injectable, InternalServerErrorException, Logger, NotFoundException, Body } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { CreateProductoDto } from './dto/create-producto.dto';
import { UpdateProductoDto } from './dto/update-producto.dto';
import { Producto } from './entities/producto.entity';
import { CategoriasService } from '../categorias/categorias.service';
import { ProveedoresService } from '../proveedores/proveedores.service';


@Injectable()
export class ProductosService {

  private readonly logger = new Logger('ProductosService')

  constructor(
    @InjectRepository(Producto)
    private readonly productoRepository : Repository<Producto>,

    private readonly categoriasService : CategoriasService,
    private readonly proveedoresService : ProveedoresService

  ){}

  async create(createProductoDto: CreateProductoDto) {
    
    try {
      
      const { categoria, proveedor, ...productoDetails } = createProductoDto;

      const cat = await this.categoriasService.findOne(categoria);

      const pro = await this.proveedoresService.findOne(proveedor);
      
      const producto = this.productoRepository.create({
        ...productoDetails,
        categoria: cat,
        proveedor: pro,
      });
      await this.productoRepository.save(producto);
      return this.respuesta('Producto agregado exitosamente');
    } catch (error) {
      this.handleExceptions(error);
    }
  }

  async findAll() {
    const productos = await this.productoRepository.findBy({activo:true});
    return this.respuesta('Proceso Exitoso', productos);
  }

  async findOne(id: string) {
    try {
      const producto = await this.productoRepository.findOneBy({id})
      if(!producto)
        throw new NotFoundException('No se encuntra un producto con ese ID');
      return this.respuesta('Proceso Exitoso',producto);
    } catch (error) {
      this.handleExceptions(error)
    }
    
  }

  async update(id: string, updateProductoDto: UpdateProductoDto) {
    const proveedor = await this.productoRepository.createQueryBuilder()
    .update({...updateProductoDto})
    .where("id = :id", {id})
    .execute()
    return this.respuesta('Producto actualizado correctamente');
  }

  async remove(id: string) {
    const producto = await this.productoRepository.createQueryBuilder()
    .update({activo: false})
    .where("id = :id", {id})
    .execute()
    return this.respuesta('Producto desactivado correctamente');
  }

  private handleExceptions( error: any ) {
    
    if(error.code === '23505')
    throw new BadRequestException('Algunos campos ya existen y son unicos');
    
    this.logger.error(error)
    throw new BadRequestException('Comunicate con el del Backend');
  }

  private respuesta(message?: string, body?: any){
    return {
      status: HttpStatus.OK,
      ok: true,
      message,
      body
    }
  }
}
