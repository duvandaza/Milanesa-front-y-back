import { BadRequestException, HttpException, HttpStatus, Injectable, InternalServerErrorException, Logger, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { CreateProveedoreDto } from './dto/create-proveedore.dto';
import { UpdateProveedoreDto } from './dto/update-proveedore.dto';
import { Proveedor } from './entities/proveedor.entity';
import { Repository } from 'typeorm';

@Injectable()
export class ProveedoresService {

  private readonly logger = new Logger('CategoriasService');

  constructor(
    @InjectRepository(Proveedor)
    private readonly proveedorRepository: Repository<Proveedor>
  ){}

  async create(createProveedoreDto: CreateProveedoreDto) {
    try {
      const proveedor = this.proveedorRepository.create(createProveedoreDto);
      await this.proveedorRepository.save(proveedor);
      return this.respuesta('Proveedor agregado exitosamente');
    } catch (error) {
      this.handleExceptions(error);
    }
  }

  async findAll() {
    const proveedores = await this.proveedorRepository.findBy({activo:true});
    return this.respuesta('Proceso Exitoso', proveedores);
  }

  async findOne(id: string) {
    const proveedor = await this.proveedorRepository.findOneBy({id});
    if(!proveedor)
      throw new NotFoundException('No se encuntra un proveedor con ese ID');
    return proveedor;
  }

  async update(id: string, updateProveedoreDto: UpdateProveedoreDto) {
    const proveedor = await this.proveedorRepository.preload({id, ...updateProveedoreDto});
    await this.proveedorRepository.save(proveedor);
    return this.respuesta('Proveedor actualizado correctamente');
  }

  async remove(id: string) {
    const proveedor = await this.proveedorRepository.createQueryBuilder()
    .update({activo: false})
    .where("id = :id", {id})
    .execute()
    return this.respuesta('Proveedor desactivado correctamente');
  }

  private handleExceptions( error: any ) {
    
    console.log(error);
    if(error.code === '23505')
    throw new BadRequestException('los campos nit o nombre ya existen');
    
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
