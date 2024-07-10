package com.kh.bookjeok.book.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MidCategory {
    private int midCategoryNo;
    private String midCategoryName;
    private Integer upperCategoryNo;
    private String categoryStatus;
}
