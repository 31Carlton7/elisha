package translation

type Translation struct {
	ID           int64  `json:"id"`
	Table        string `json:"table"`
	Language     string `json:"language"`
	Abbreviation string `json:"abbreviation"`
	Version      string `json:"version"`
	InfoURL      string `json:"infoUrl,omitempty"`
}

type TranslationCollection []Translation
