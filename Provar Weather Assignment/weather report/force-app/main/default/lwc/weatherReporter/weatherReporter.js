import { LightningElement, wire, api } from 'lwc';
import getLatestWeather from '@salesforce/apex/WeatherReporterController.getWeatherReport';

export default class WeatherReporter extends LightningElement {
    @api recordId; 

    weather;
    error;

    @wire(getLatestWeather, { LocationRecordId : '$recordId' }) weatherReport({ error, data }) {
        if (data) {
            this.weather = data;
            this.error = undefined;

        } else if (error) {
            this.error = error;
            this.weather = undefined;
        }
    }


}