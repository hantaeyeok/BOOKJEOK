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
public class UpperCategory {
    private int upperCategoryNo;
    private String upperCategoryName;
    private Integer topCategoryNo;
    private String categoryStatus;
}
