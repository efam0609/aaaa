
package clases;

import com.jtattoo.plaf.aero.AeroLookAndFeel;
import com.jtattoo.plaf.graphite.GraphiteLookAndFeel;
import com.jtattoo.plaf.luna.LunaLookAndFeel;
import formularios.frmBienvenida;
import javax.swing.JOptionPane;
import javax.swing.UIManager;

public class SisClinicaDental {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
              
        try {
            //Si no utilizamos ningun tema, dejar el predeterminado de windows, sólo descomentar el for
            /*
            for (LookAndFeelInfo info : UIManager.getInstalledLookAndFeels()) {
                if ("Windows".equals(info.getName())) {
                    UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
            */
            //Tema de jTattoo
            UIManager.setLookAndFeel(new AeroLookAndFeel());
        }
        catch(Exception e)
        {
            JOptionPane.showMessageDialog(null, "Error en Look And Feel","Error:" + e.getMessage(), 
                    JOptionPane.ERROR_MESSAGE);
        }        
                
        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {

            @Override
            public void run() 
            {
                new Thread(new frmBienvenida()).start();
            }
        }); 
    }
}
