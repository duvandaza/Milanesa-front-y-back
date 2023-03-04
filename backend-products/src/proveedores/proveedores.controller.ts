import { Controller, Get, Post, Body, Patch, Param, Delete, ParseUUIDPipe, HttpStatus } from '@nestjs/common';
import { ProveedoresService } from './proveedores.service';
import { CreateProveedoreDto } from './dto/create-proveedore.dto';
import { UpdateProveedoreDto } from './dto/update-proveedore.dto';

@Controller('proveedores')
export class ProveedoresController {
  constructor(private readonly proveedoresService: ProveedoresService) {}

  @Post()
  create(@Body() createProveedoreDto: CreateProveedoreDto) {
    return this.proveedoresService.create(createProveedoreDto);
  }

  @Get()
  findAll() {
    return this.proveedoresService.findAll();
  }

  @Get(':id')
  async findOne(@Param('id', ParseUUIDPipe) id: string) {
    const proveedor = await this.proveedoresService.findOne(id);
    return {
      statusCode: HttpStatus.OK,
      ok: true,
      body: proveedor
    }
  }

  @Patch(':id')
  update(@Param('id', ParseUUIDPipe) id: string, @Body() updateProveedoreDto: UpdateProveedoreDto) {
    return this.proveedoresService.update(id, updateProveedoreDto);
  }

  @Delete(':id')
  remove(@Param('id', ParseUUIDPipe) id: string) {
    return this.proveedoresService.remove(id);
  }
}
