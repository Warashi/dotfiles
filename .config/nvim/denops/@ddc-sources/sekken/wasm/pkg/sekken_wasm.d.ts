/* tslint:disable */
/* eslint-disable */
/**
*/
export function init(): void;
/**
*/
export function use_default_kana_table(): void;
/**
* @param {any} map
*/
export function set_kana_table(map: any): void;
/**
* @param {any} dict
*/
export function set_skk_dictionary(dict: any): void;
/**
* @param {string} roman
* @returns {(string)[]}
*/
export function henkan(roman: string): (string)[];
/**
* @param {Uint8Array} data
*/
export function set_model(data: Uint8Array): void;
/**
* @param {string} roman
* @param {number} n
* @returns {(string)[]}
*/
export function viterbi_henkan(roman: string, n: number): (string)[];
