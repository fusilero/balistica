/* Copyright 2018 Steven Oliver <oliver.steven@gmail.com>
 *
 * This file is part of balística.
 *
 * balística is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * balística is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with balística.  If not, see <http://www.gnu.org/licenses/>.
 */

public class LogMsg {

   public enum LogLevel {
	  DEBUG,
	  INFO,
	  WARNING,
	  ERROR,
	  FATAL ;

	  public string to_string() {
		 switch( this ){
		 case DEBUG:
			return "DEBUG" ;

		 case INFO:
			return "INFO" ;

		 case WARNING:
			return "WARNING" ;

		 case ERROR:
			return "ERROR" ;

		 case FATAL:
			return "FATAL" ;

		 default:
			assert_not_reached () ;
		 }
	  }

   }

   public LogLevel level { get ; set ; }
   public string message { get ; set ; }

   public LogMsg (string message) {
	  this.full (LogLevel.ERROR, message) ;
   }

   public LogMsg.full (LogLevel level, string message) {
	  this.level = level ;
	  this.message = message ;
   }
}

