import { IsBoolean, IsOptional, IsString, MinLength } from "class-validator";

export class CreateProveedoreDto {

    @IsString()
    @MinLength(2)
    nombre: string;

    @IsString()
    @MinLength(2)
    nit: string;
    
    @IsString()
    direccion: string;
    
    @IsString()
    @MinLength(10)
    telefono: string;

}
