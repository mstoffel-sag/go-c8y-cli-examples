local ok = if _.Float(0, 1) > 0.9 then 1 else 0;

{
    type: ['c8y_PartOk', 'c8y_PartNOk'][ok],
    text: ['Part Ok', 'Part not ok'][ok]
}