// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.springsource.petclinic.repository;

import com.mysema.query.BooleanBuilder;
import com.mysema.query.jpa.JPQLQuery;
import com.mysema.query.types.Order;
import com.mysema.query.types.OrderSpecifier;
import com.mysema.query.types.path.NumberPath;
import com.springsource.petclinic.domain.Owner;
import com.springsource.petclinic.domain.Pet;
import com.springsource.petclinic.domain.QPet;
import com.springsource.petclinic.repository.GlobalSearch;
import com.springsource.petclinic.repository.PetRepositoryCustom;
import com.springsource.petclinic.repository.PetRepositoryImpl;
import java.util.List;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.transaction.annotation.Transactional;

privileged aspect PetRepositoryImpl_Roo_Jpa_Repository_Impl {
    
    declare parents: PetRepositoryImpl implements PetRepositoryCustom;
    
    declare @type: PetRepositoryImpl: @Transactional(readOnly = true);
    
    public Page<Pet> PetRepositoryImpl.findAll(GlobalSearch globalSearch, Pageable pageable) {
        NumberPath<Long> idPet = new NumberPath<Long>(Long.class, "id");
        QPet pet = QPet.pet;
        JPQLQuery query = getQueryFrom(pet);
        BooleanBuilder where = new BooleanBuilder();

        if (globalSearch != null) {
            String txt = globalSearch.getText();
            where.and(
                pet.name.containsIgnoreCase(txt)
                .or(pet.weight.like("%".concat(txt).concat("%")))
            );

        }
        query.where(where);

        long totalFound = query.count();
        if (pageable != null) {
            if (pageable.getSort() != null) {
                for (Sort.Order order : pageable.getSort()) {
                    Order direction = order.isAscending() ? Order.ASC : Order.DESC;

                    switch(order.getProperty()){
                        case "name":
                           query.orderBy(new OrderSpecifier<String>(direction, pet.name));
                           break;
                        case "weight":
                           query.orderBy(new OrderSpecifier<Float>(direction, pet.weight));
                           break;
                    }
                }
            }
            query.offset(pageable.getOffset()).limit(pageable.getPageSize());
        }
        query.orderBy(idPet.asc());
        
        List<Pet> results = query.list(pet);
        return new PageImpl<Pet>(results, pageable, totalFound);
    }
    
    public Page<Pet> PetRepositoryImpl.findAllByOwner(Owner ownerField, GlobalSearch globalSearch, Pageable pageable) {
        NumberPath<Long> idPet = new NumberPath<Long>(Long.class, "id");
        QPet pet = QPet.pet;
        JPQLQuery query = getQueryFrom(pet);
        BooleanBuilder where = new BooleanBuilder(pet.owner.eq(ownerField));

        if (globalSearch != null) {
            String txt = globalSearch.getText();
            where.and(
                pet.name.containsIgnoreCase(txt)
                .or(pet.weight.like("%".concat(txt).concat("%")))
            );

        }
        query.where(where);

        long totalFound = query.count();
        if (pageable != null) {
            if (pageable.getSort() != null) {
                for (Sort.Order order : pageable.getSort()) {
                    Order direction = order.isAscending() ? Order.ASC : Order.DESC;

                    switch(order.getProperty()){
                        case "name":
                           query.orderBy(new OrderSpecifier<String>(direction, pet.name));
                           break;
                        case "weight":
                           query.orderBy(new OrderSpecifier<Float>(direction, pet.weight));
                           break;
                    }
                }
            }
            query.offset(pageable.getOffset()).limit(pageable.getPageSize());
        }
        query.orderBy(idPet.asc());
        
        List<Pet> results = query.list(pet);
        return new PageImpl<Pet>(results, pageable, totalFound);
    }
    
}
