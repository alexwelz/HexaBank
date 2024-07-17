package daoImpl;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import entidad.TipoUsuario;
import entidad.Usuario;
import dao.UsuarioDao;
import daoImpl.Conexion;


public class UsuarioDaoImpl implements UsuarioDao {

	private static final String update = "UPDATE usuarios SET nombre_usuario = ?, password = ?,tipo_usuario_id = ? WHERE usuario_id = ?";
	private static final String insert = "INSERT INTO usuarios(nombre_usuario, password, tipo_usuario_id) VALUES(?, ?, ?)";	
	private static final String list = "SELECT * FROM usuarios";
	private static final String get = "SELECT * FROM usuarios WHERE usuario_id = ?";
	private static final String queryExiste = "SELECT COUNT(*) FROM usuarios WHERE estado = 1 AND nombre_usuario = ?";
	private static final String queryBuscar = "SELECT usuario_id, nombre_usuario, password, tipo_usuario_id FROM usuarios WHERE estado = 1 AND nombre_usuario = ?";
	
	
	@Override
	public boolean insert(Usuario usuario) {
		try 
    	{
    		Class.forName("com.mysql.jdbc.Driver");
    	}catch (ClassNotFoundException e){
    		e.printStackTrace();
    	} 
		    PreparedStatement statement;
		    Connection conexion = Conexion.getConexion().getSQLConexion();
		    boolean isInsertExitoso = false;
		    try
		    {
		        statement = conexion.prepareStatement(insert);
		        statement.setString(1, usuario.getNombreUsuario());
		        statement.setString(2,usuario.getPassword());
		        statement.setInt(3,usuario.getTipoUsuario().getTipoUsuarioId());     
		        if(statement.executeUpdate() > 0)
		        {
		            conexion.commit();
		            isInsertExitoso = true;
		        }
		    } 
		    catch (SQLException e) 
		    {
		        e.printStackTrace();
		        try {
		            conexion.rollback();
		        } catch (SQLException e1) {
		            e1.printStackTrace();
		        }
		    }
		    return isInsertExitoso;
	}

	@Override
	public boolean update(Usuario usuario) {
		try 
    	{
    		Class.forName("com.mysql.jdbc.Driver");
    	}catch (ClassNotFoundException e){
    		e.printStackTrace();
    	}
		
		    PreparedStatement statement;
	        Connection conexion = Conexion.getConexion().getSQLConexion();
	        boolean isUpdateExitoso = false;
	        try {
	        	statement = conexion.prepareStatement(update);
		        statement.setString(1, usuario.getNombreUsuario());
		        statement.setString(2,usuario.getPassword());
		        statement.setInt(3,usuario.getTipoUsuario().getTipoUsuarioId());
		        statement.setInt(4,usuario.getUsuarioId());
	            
	            if (statement.executeUpdate() > 0) {
	                conexion.commit();
	                isUpdateExitoso = true;
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	            try {
	                conexion.rollback();
	            } catch (SQLException e1) {
	                e1.printStackTrace();
	            }
	        }
	        return isUpdateExitoso;
	}

	@Override
	public Usuario get(int usuario_id) {
		try 
    	{
    		Class.forName("com.mysql.jdbc.Driver");
    	}catch (ClassNotFoundException e){
    		e.printStackTrace();
    	}
		PreparedStatement statement;
		Connection conexion = Conexion.getConexion().getSQLConexion();
		
		try {
			statement = conexion.prepareStatement(get);
			statement.setInt(1, usuario_id);
			ResultSet result_set = statement.executeQuery();
			while(result_set.next()) {
				
				TipoUsuarioDaoImpl tipoUsuarioDaoImpl = new TipoUsuarioDaoImpl();
				String nombre_usuario = result_set.getString("nombre_usuario");
				String password = result_set.getString("password");
				TipoUsuario tipo_usuario = tipoUsuarioDaoImpl.get(result_set.getInt("tipo_usuario_id"));
				int id_usuario = result_set.getInt("usuario_id");
				Usuario usuario = new Usuario(id_usuario,nombre_usuario,password,tipo_usuario);
				return usuario;
			}
		}		
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public ArrayList<Usuario> list() {
		try 
    	{
    		Class.forName("com.mysql.jdbc.Driver");
    	}catch (ClassNotFoundException e){
    		e.printStackTrace();
    	}
		ArrayList<Usuario> list_usuarios = new ArrayList<Usuario>();
		try {
			Connection conexion = Conexion.getConexion().getSQLConexion();
			Statement statement = conexion.createStatement();
			ResultSet result_set = statement.executeQuery(list);
			while(result_set.next()) {
				
				String nombre_usuario = result_set.getString("nombre_usuario");
				String password = result_set.getString("password");
				TipoUsuarioDaoImpl tipoUsuarioDaoImpl = new TipoUsuarioDaoImpl();
				TipoUsuario tipo_usuario = tipoUsuarioDaoImpl.get(result_set.getInt("tipo_usuario_id"));
				int id_usuario = result_set.getInt("usuario_id");
				Usuario usuario = new Usuario(id_usuario,nombre_usuario,password,tipo_usuario);

				list_usuarios.add(usuario);
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return list_usuarios;
	}
	
	@Override
    public boolean existeNombreUsuario(String nombre) {
        try 
    	{
    		Class.forName("com.mysql.jdbc.Driver");
    	}catch (ClassNotFoundException e){
    		e.printStackTrace();
    	}
        
        boolean existe = false;
        
        try {
        	Connection conexion = Conexion.getConexion().getSQLConexion();
        	PreparedStatement statement = conexion.prepareStatement(queryExiste);
            statement.setString(1, nombre);
            ResultSet resultSet = statement.executeQuery();
            
            if (resultSet.next()) {
                int count = resultSet.getInt(1);
                if (count > 0) {
                    existe = true;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return existe;
    }
	
	@Override
    public Usuario buscarUsuario(String nombreUsuario) {
        try 
    	{
    		Class.forName("com.mysql.jdbc.Driver");
    	}catch (ClassNotFoundException e){
    		e.printStackTrace();
    	}
        
        Usuario usuario = null;

        try {
            Connection conexion = Conexion.getConexion().getSQLConexion();
            PreparedStatement statement = conexion.prepareStatement(queryBuscar);
            statement.setString(1, nombreUsuario);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
            	int id = resultSet.getInt("usuario_id");
                String nombre = resultSet.getString("nombre_usuario");
                String password = resultSet.getString("password");
				TipoUsuarioDaoImpl tipoUsuarioDaoImpl = new TipoUsuarioDaoImpl();
				TipoUsuario tipoUsuario = tipoUsuarioDaoImpl.get(resultSet.getInt("tipo_usuario_id"));

                usuario = new Usuario();
                usuario.setUsuarioId(id);
                usuario.setNombreUsuario(nombre);
                usuario.setPassword(password);
                usuario.setTipoUsuario(tipoUsuario);
            } 

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return usuario;
        
    }


}
