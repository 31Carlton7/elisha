package common

import (
	"strings"
)

type TranslationFactory struct{}

func (t TranslationFactory) GetTable(key string) (table string) {
	key = strings.ToLower(key)

	switch key {
	case "t_asv":
	case "asv":
		table = "t_asv"
	case "t_bbe":
	case "bbe":
		table = "t_bbe"
	case "t_dby":
	case "dby":
		table = "t_dby"
	case "t_kjv":
	case "kjv":
		table = "t_kjv"
	case "t_wbt":
	case "wbt":
		table = "t_wbt"
	case "t_web":
	case "web":
		table = "t_web"
	case "t_ylt":
	case "ylt":
		table = "t_ylt"
	case "t_esv":
	case "esv":
		table = "t_esv"
	case "t_niv":
	case "niv":
		table = "t_niv"
	case "t_nlt":
	case "nlt":
		table = "t_nlt"
	default:
		table = "t_kjv"
	}

	return
}

func (t TranslationFactory) GetIndex(key string) (index string) {
	key = strings.ToLower(key)

	switch key {
	case "t_asv":
	case "asv":
		index = "asv"
	case "t_bbe":
	case "bbe":
		index = "bbe"
	case "t_dby":
	case "dby":
		index = "dby"
	case "t_kjv":
	case "kjv":
		index = "kjv"
	case "t_wbt":
	case "wbt":
		index = "wbt"
	case "t_web":
	case "web":
		index = "web"
	case "t_ylt":
	case "ylt":
		index = "ylt"
	case "t_esv":
	case "esv":
		index = "esv"
	case "t_niv":
	case "niv":
		index = "niv"
	case "t_nlt":
	case "nlt":
		index = "nlt"
	default:
		index = "kjv"
	}

	return
}
