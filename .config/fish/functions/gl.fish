# Defined in - @ line 1
function gl --description 'alias gl=git log --pretty=oneline'
	git log --pretty=oneline $argv;
end
