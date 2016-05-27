// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.springsource.petclinic.format;

import com.springsource.petclinic.domain.Pet;
import com.springsource.petclinic.format.PetFormatter;
import com.springsource.petclinic.service.api.PetService;
import java.text.ParseException;
import java.util.Locale;
import org.springframework.core.convert.ConversionService;
import org.springframework.format.Formatter;
import org.springframework.util.StringUtils;

privileged aspect PetFormatter_Roo_Formatter {
    
    declare parents: PetFormatter implements Formatter<Pet>;
    
    public PetService PetFormatter.petService;
    
    public ConversionService PetFormatter.conversionService;
    
    public PetFormatter.new(PetService petService, ConversionService conversionService) {
        this.petService = petService;
        this.conversionService = conversionService;
    }

    public Pet PetFormatter.parse(String text, Locale locale) throws ParseException {
        if (text == null || !StringUtils.hasText(text)) {
            return null;
        }
        Long id = conversionService.convert(text, Long.class);
        return petService.findOne(id);
    }
    
    public String PetFormatter.print(Pet pet, Locale locale) {
        return pet == null ? null : new StringBuilder().append(pet.isSendReminders()).append(" - ").append(pet.getName()).append(" - ").append(pet.getWeight()).toString();
    }
    
}
