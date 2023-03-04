import { Module } from '@nestjs/common';
import { ProveedoresService } from './proveedores.service';
import { ProveedoresController } from './proveedores.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Proveedor } from './entities/proveedor.entity';

@Module({
  controllers: [ProveedoresController],
  providers: [ProveedoresService],
  imports: [
    TypeOrmModule.forFeature([Proveedor]),
  ],
  exports: [
    ProveedoresService,
    TypeOrmModule,
  ]
})
export class ProveedoresModule {}
