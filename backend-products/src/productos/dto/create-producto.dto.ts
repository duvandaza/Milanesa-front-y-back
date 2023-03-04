import { IsBoolean, IsInt, IsNumber, IsOptional, IsPositive, IsString, MinLength } from "class-validator";


export class CreateProductoDto {

    @IsString()
    @MinLength(1)
    nombre: string;

    @IsInt()
    @IsPositive()
    @IsOptional()
    cantidad?: number;

    @IsNumber()
    @IsPositive()
    precio: number;

    @IsString()
    presentacion: string;
    
    @IsString()
    @IsOptional()
    descripcion?: string;

    @IsString()
    @IsOptional()
    categoria?: string;

    @IsString()
    @IsOptional()
    proveedor?: string;

    @IsString()
    @IsOptional()
    imagen: string;

}
