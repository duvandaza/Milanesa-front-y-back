import { IsInt, IsNumber, IsOptional, IsPositive, IsString, MinLength } from "class-validator";

export class UpdateProductoDto  {

    @IsString()
    @MinLength(1)
    @IsOptional()
    nombre?: string;

    @IsInt()
    @IsPositive()
    @IsOptional()
    cantidad?: number;

    @IsNumber()
    @IsPositive()
    @IsOptional()
    precio?: number;

    @IsString()
    @IsOptional()
    presentacion?: string;
    
    @IsString()
    @IsOptional()
    descripcion?: string;
    
    @IsString()
    @IsOptional()
    imagen?: string;

}
