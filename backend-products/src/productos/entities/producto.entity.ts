import { Column, Entity, ManyToOne, PrimaryGeneratedColumn } from "typeorm";
import { Categoria } from '../../categorias/entities/categoria.entity';
import { Proveedor } from '../../proveedores/entities/proveedor.entity';

@Entity({name: 'productos'})
export class Producto {

    @PrimaryGeneratedColumn('uuid')
    id: string;

    @Column('text')
    nombre: string;

    @Column('int', {
        default: 0
    })
    cantidad: number;

    @Column('float', {
        default: 0,
    })
    precio: number;

    @Column('bool', {
        default: true
    })
    activo: boolean;

    @Column('text')
    presentacion: string;

    @Column('text')
    descripcion: string;

    @Column('text')
    imagen: string;

    @ManyToOne(
        () => Categoria,
        (categoria) => categoria.producto
    )
    categoria: Categoria;

    @ManyToOne(
        () => Proveedor,
        (proveedor) => proveedor.producto 
    )
    proveedor: Proveedor;


}
