import { Column, Entity, OneToMany, PrimaryGeneratedColumn } from "typeorm";
import { Producto } from '../../productos/entities/producto.entity';

@Entity()
export class Proveedor {


    @PrimaryGeneratedColumn('uuid')
    id: string;

    @Column('text', {
        unique: true,
    })
    nombre: string;

    @Column('bool', {
        default: true
    })
    activo: boolean;

    @Column('text', {
        unique: true
    })
    nit: string;

    @Column('text')
    telefono: string;

    @Column('text')
    direccion: string;

    @OneToMany(
        () => Producto,
        (producto) => producto.proveedor
    )
    producto: Producto;

}
