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
public class LowerCategory {
    private int lowerCategoryNo;
    private String lowerCategoryName;
    private Integer midCategoryNo;
    private String categoryStatus;
}
