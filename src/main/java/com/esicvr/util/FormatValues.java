package com.esicvr.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class FormatValues {

	public String formatarData(Date data) throws ParseException {
		SimpleDateFormat format_ = new SimpleDateFormat("dd/MM/yyyy");
		String dataFormatada = format_.format(data.getTime());
		return dataFormatada;

	}

	public Date formatDateStringInTypeDate(String data) throws ParseException {
		SimpleDateFormat formatter = new SimpleDateFormat("dd-MMM-yyyy");
		String dateInString = data;
		Date date = formatter.parse(dateInString);
		return date;
	}
}