/*
 * Copyright (C) 2018, RISE Research Institutes of Sweden AB.
 */

package se.sics.prologbeans;

/**
 * A string contained unsupported characters
 *
 */
public class IllegalCharacterSetException extends Exception {
    private static final long serialVersionUID = 1L;

    IllegalCharacterSetException(String str) {
        super(str);
    }
}
