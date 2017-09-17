\name{Readings}
\alias{Readings}
\docType{data}
\title{
Readings
}
\description{
Contains meter readings in kilowatt hours (kWh) at 5 minute intervals.
}
\usage{data("Readings")}
\format{
  A data frame with 22,176 observations on the following 7 variables.
  \describe{
    \item{\code{TimeStamp}}{a time stamp vector of class POSIXct}
    \item{\code{Meter1}}{a numeric vector containing kWh readings for Meter 1}
    \item{\code{Meter2}}{a numeric vector containing kWh readings for Meter 2}
    \item{\code{Meter3}}{a numeric vector containing kWh readings for Meter 3}
    \item{\code{Total}}{a numeric vector containing the sum of Meter 1, Meter 2 and Meter 3 kWh }
    \item{\code{hour}}{a factor variable for hour of the day}
    \item{\code{day}}{a factor variable for day of the week}
  }
}
\details{
This data file contains the meter readings for a residential dwelling located in Perth, Western Australia. Demographic information: 4 permanent occupants; family; two professional income earners; one university student; one high school student.{\cr} {\cr}

The dwelling is supplied by three-phase power to support the use of the following electrical appliances:{\cr} {\cr}
(1) A reverse cycle air-conditioner unit (HVAC) (Fujitsu brand); Model: AOT45RCD3L;
serial number: T002828. Specifications: Input power cooling 4,570 Watts (cassette ceiling), 5,050 Watts (duct), Heating 4350 W (cassette ceiling), 4,380 Watss (duct); Refrigerant R22. {\cr} {\cr}

(2) Two  pool pumps (Astral Pool brand) for water filtration and cleaning. Specifications: 240 Volts, single phase  50 Hz, 1,645 Watts, 7.2 Amps, 2,830 RPM; serial numbers: BXDA09110000, PBC04112149. {\cr} {\cr} One of these pumps is activated by a timer and has a variable speed regulator attached to minimise electricity consumption. This pump is activated twice per day. The other pump is for the in-floor cleaning system and is activated manually depending on the number of leaves in the pool. {\cr} {\cr}

(3) One pump for the solar heating system. Specifications: 240 Volts; single phase 50 Hz; 680 Watts; 2.9 Amps; 2830 RPM; Serial number: ECFA11116657; date of manufacture: 10 November 2011.This pump is activated by a temperature sensor. The pump will activate for heating when (i) the temperature in the pool is below target and (ii) the temperature differential between the dwelling's roof and the pool water is sufficient to add heat to the pool water. {\cr} {\cr} The pump can also be used for cooling pool water (tropical setting) when (i) the pool water temperature is above the target temperature and (ii) the temperature differential between dwelling roof and the pool water will reduce the temperature of the pool water when the pump is activated. There is a also a winter mode in which the pump is activated once per day to flush the pipe system. {\cr} {\cr}

(4) Two pool pumps for swim jets, which create a water flow in the pool sufficient to hold a swimmer stationary in the water when swimming against the flow of water. Specifications: 240 Volts; 8.3 Amps; 
1,900 Watts; 2,830 RPM; serial number CTXEB0711074, CTXEB06118325; date of manufacture: 6 July 2011.{\cr} {\cr}
These pumps are typically used together, but to date have been used infrequently. {\cr} {\cr}

(5) One refrigerator (Whirlpool brand). Specifications: 6ER9GTKXK; rated consumption is 632 kWh/year; total volume of 567 Litres; date of sale: April 2007. {\cr} {\cr}

(6) One washing machine (front load, Westinghouse brand). Specifications: Model number LF708C; 240 Volts; 50 Hz; Capacity 7 kg; Input heating 2100 watts; serial number: 408KWYP00546.  {\cr} {\cr}

(7A) One television (Samsung brand). Specifications: model number LA40B650T1F; model Code: LA40B650T1FXXY; type number: LA40B650; AC 220 to 240 Volts; 50 Hz; 200 Watts; serial number: AUZT3MNS400108Z.{\cr} {\cr}

(7B)  One television (JVC brand):  Specifications: TV model number LT-Z37Ex6; 110-240 Volts; 163 Watts; 0.89 Amps; Serial number 06200455. Used soley with Xbox game console.{\cr} {\cr}

(8A) Two Play Station PS3 game consoles.{\cr} {\cr}

(8B) One xBox game console. {\cr} {\cr}

(9) One home Internet router (Netgear brand). Specifications: model number DGND3700v2;
Serial number 2TW22CBP01ADB.

(10) Four cell phones iPhones (Apple brand). Specifications: model number A1530.{\cr} {\cr}

(11) Two computer monitors (ViewSonic brand). Specifications: model number VA2226w-7 model number VS12071; serial number QX6081911966.{\cr} {\cr}

(12) One lap top computer (Toshiba brand). Specifications: model Notebook; processor Intel Core i5 CPU M 480 @ 2.67 GHz; 64-bit operating system.{\cr} {\cr}

(13) One lap top computer (Apple brand). Specifications: Mac Pro; year of manufacture: 2014{\cr} {\cr}

(14) One lap top computer (Apple brand). Specifications: Macbook Air; year of manufacture: 2011 {\cr} {\cr}

(15) Two tablet computers (Apple brand). {\cr} {\cr}

(16) One electric kettle (Breville brand).{\cr} {\cr}

(17) One microwave oven (Samsung brand).Specifications: capacity: 35 Litres.{\cr} {\cr}

(18) One electric oven (Fisher & Paykel brand). Specifications: model number: OB60SL11.{\cr} {\cr}

(19) One dishwasher (Dishlex brand). Specifications: model: DX103WK; year of purchase: 2002.{\cr} {\cr}








}
\source{
%%  ~~ reference to a publication or URL from which the data were obtained ~~
}
\references{
%%  ~~ possibly secondary sources and usages ~~
}
\examples{
data(Readings)
## maybe str(Readings) ; plot(Readings$Total) ...
}
\keyword{datasets}
