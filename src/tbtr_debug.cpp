#include "tbtr_debug.h"

void tbtrdbg::chain(const Vehicle* v)
{
	if (!v) return;
	std::cout << "\t" << v->engine_type << std::endl;
	chain(v->Next());
}

void tbtrdbg::vehicle(const Vehicle* v)
{
	if (!v) return;
	std::cout << "dbg veh: " << v->index << ", type: " << v->type << std::endl;
	chain(v);
}
