import java.util.*;

/***
 * Manages a game of 'Assassin'. Takes in a list of Players that become part of the 'Kill Ring'.
 * Each Player is stalking the next Player after them in the list, but the Player does not know
 * who is stalking him/her. When a Player is killed they are moved to the front of the 'Graveyard'.
 * When there is only one Player remaining in the Kill Ring, it is Game Over and that final Player
 * is the winner.
 *
 * @author John Wielenga
 * @version 1.0
 * @since 11-3-2016
 */

public class AssassinManager{

   /**
    * stores the kill ring and graveyard so that it can be accessed
    */
   private AssassinNode frontOfKillRing;
   private AssassinNode frontOfGraveyard;


   /**
    * Takes in a list of names to connect together to form our kill ring
    *
    * @pre the list of names has at least one name (is not empty)
    * @post builds a kill ring of individually connected assassin nodes
    */
   public AssassinManager(List<String> names){
      if(names == null || names.size() == 0){
         throw new IllegalArgumentException("No names to process!");
      }
      for(int i = 0; i < names.size(); i++){
         String name = names.get(i);
         AssassinNode assassin = new AssassinNode(name);

         if(frontOfKillRing == null){
            frontOfKillRing = assassin;
         } else {
            AssassinNode current = frontOfKillRing;
            while(current.next != null){
               current = current.next;
            }
            current.next = assassin;
         }
      }
   }

   /**
    * prints the players that are currently in the kill ring and who they are stalking
    */
   public void printKillRing(){
      System.out.println("Current kill ring:");
      AssassinNode current = frontOfKillRing;
      while(current != null){
         if(current.next == null){
            System.out.println("\t" + current.name + " is stalking " + frontOfKillRing.name);
         } else {
            System.out.println("\t" + current.name + " is stalking " + current.next.name);
         }
         current = current.next;
      }
   }

    /**
     * prints the players that are currently in graveyard along with the person who killed them
     */
    public void printGraveyard(){
      if(!isGameOver()){
         System.out.println("Current graveyard:");
      } else {
         System.out.println("The final graveyard is as follows:");
      }

      AssassinNode current = frontOfGraveyard;
      while(current != null){
         if(current.next == null){
            System.out.println("\t" + current.name + " was killed by " + current.killer);
         } else {
            System.out.println("\t" + current.name + " was killed by " + current.killer);
         }
         current = current.next;
      }
      System.out.println();
    }

   /**
    * checks the kill ring to see if it contains the given name
    * @return true or false if the kill ring contains name
    */
   public boolean killRingContains(String name){
      AssassinNode current = frontOfKillRing;
      while(current != null){
         if(current.name.equals(name)){
            return true;
         }
         current = current.next;
      }
      return false;
   }

   /**
    * checks the graveyard to see if it contains the given name
    * @return true or false if the graveyard contains name
    */
   public boolean graveyardContains(String name){
      AssassinNode current = frontOfGraveyard;
      while(current != null){
         if(current.name.equals(name)){
            return true;
         }
         current = current.next;
      }
      return false;
   }

   /**
    * if one person left in kill ring, game is over
    * @return whether or not there is one person left in the kill ring
    */
   public boolean isGameOver(){
      return (frontOfKillRing.next == null);
   }

   /**
    * last person left in the kill ring is the winner
    * @return the name of the last person left in the kill ring
    */
   public String winner(){
      return frontOfKillRing.name;
   }

   /*
    * @pre game is NOT over
    * @pre the kill ring contains the given name
    * @post removes victim from the kill ring, recording the name of their killer,
    * then moves them to the front of the graveyard.
    */
   public void kill(String name){
      if(isGameOver()){
         throw new IllegalStateException();
      }
      if(!killRingContains(name)){
         throw new IllegalArgumentException("Player does not exist in Kill Ring!");
      } else {
         AssassinNode theFallen = null;

         // Remove the victim from the Kill Ring
         if(frontOfKillRing.name.equals(name)){          //if victim IS at front of kill ring
            String assassin = null;
            AssassinNode current = frontOfKillRing;
            while(current != null){
               if(current.next == null){
                  assassin = current.name;
               }
               current = current.next;
            }
            theFallen = frontOfKillRing;
            theFallen.killer = assassin;
            frontOfKillRing = frontOfKillRing.next;

         } else {                                        //if victim NOT at front of kill ring
            AssassinNode current = frontOfKillRing;
            while(current.next != null){
               if(current.next.name.equals(name)){
                  String assassin = current.name;
                  theFallen = current.next;
                  theFallen.killer = assassin;
                  if(current.next.next != null){         //if there IS someone after the victim in list
                     current.next = current.next.next;
                     break;
                  } else {                               //if there is NOT someone after the victim
                     current.next = null;
                     break;
                  }
               }
               current = current.next;
            }
         }

         // Place the victim at the front of the Graveyard
         if(frontOfGraveyard != null){
            theFallen.next = frontOfGraveyard;
         } else {
            theFallen.next = null;
         }
         frontOfGraveyard = theFallen;
      }
   }
}
