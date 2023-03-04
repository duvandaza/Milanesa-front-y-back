import { BadRequestException, HttpException, HttpStatus, Injectable, InternalServerErrorException, Logger, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { CreateCategoriaDto } from './dto/create-categoria.dto';
import { UpdateCategoriaDto } from './dto/update-categoria.dto';
import { Categoria } from './entities/categoria.entity';

@Injectable()
export class CategoriasService {

  private readonly logger = new Logger('CategoriasService');

  constructor(
    @InjectRepository(Categoria)
    private readonly categoriaRepository : Repository<Categoria>,
  ){}

  async create(createCategoriaDto: CreateCategoriaDto) {
    try {
      createCategoriaDto.nombre = createCategoriaDto.nombre.toLocaleLowerCase();
      const categoria = this.categoriaRepository.create(createCategoriaDto);
      await this.categoriaRepository.save(categoria);
      return this.respuesta('Categoria agregada exitosamente');
    } catch (error) {
      this.handleExceptions(error);
    }
  }

  async findAll() {
    const categorias = await this.categoriaRepository.findBy({activo:true})
    return this.respuesta('Proceso Exitoso', categorias);
  }

  async findOne(id: string) {
    const categoria = await this.categoriaRepository.findOneBy({id})
    if(!categoria)
      throw new NotFoundException('No se encuntra una categoria con ese ID');
    return categoria;
  }

  async update(id: string, updateCategoriaDto: UpdateCategoriaDto) {
    const categoria = await this.categoriaRepository.preload({id, ...updateCategoriaDto});
    await this.categoriaRepository.save(categoria);
    return this.respuesta('Categoria actualizada correctamente');
  }

  async remove(id: string) {
    const categoria = await this.categoriaRepository.createQueryBuilder()
    .update({activo: false})
    .where("id = :id", {id})
    .execute()
    return this.respuesta('Categoria desactivada correctamente');
  }

  private handleExceptions( error: any ) {
    console.log(error);
    if(error.code === '23505')
      throw new BadRequestException('Ya Existe una categoria con ese nombre');
    
    throw new BadRequestException('Comunicate con el del Backend');
  }

  private respuesta(message?: string, body?: any){
    return{
      status: HttpStatus.OK,
      ok: true,
      message,
      body
    }
  }

}
