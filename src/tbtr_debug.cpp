#include "tbtr_debug.h"

template <typename T>
void tbtrdbg::chain(const T* v)
{
	if (!v) {
		std::cout << std::endl;
		return;
	}
	std::cout << "\t" << v->index << ":" << v->engine_type;
	chain(v->Next());
}

template <typename T>
void tbtrdbg::vehicle(const T* v)
{
	if (!v) return;
	std::cout << "vehicle: " << v->index << ":" << v->type << std::endl;
	chain(v);
}

void tbtrdbg::all_trains()
{
	Train* t;
	FOR_ALL_TRAINS(t)
	{
		vehicle(t);
	}
}

void tbtrdbg::all_templates()
{
	TemplateVehicle* tv;
	FOR_ALL_TEMPLATES(tv)
	{
		vehicle(tv);
	}
}
