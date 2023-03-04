import { Column, Entity, OneToMany, PrimaryGeneratedColumn } from "typeorm";
import { Producto } from '../../productos/entities/producto.entity';


@Entity()
export class Categoria {

    @PrimaryGeneratedColumn('uuid')
    id: string;
    
    @Column('text', {
        unique: true,
    })
    nombre: string;

    @Column('bool',{
        default: true
    })
    activo: boolean

    @OneToMany(
        ()=> Producto,
        (producto) => producto.categoria
    )
    producto: Producto;

}
