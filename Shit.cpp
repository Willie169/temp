#include <iostream>
#include <memory>
#include <vector>
#include <string>

using namespace std;

class shit;

class anus {
public:
    string name;
    vector<shared_ptr<shit>> shits;

    anus(string a) : name(a) {}
};

class shit {
public:
    string name;
    anus* owner;
    vector<shared_ptr<shit>> linkTo;

    shit(string a, anus* b) : name(a), owner(b) {
        cout << owner->name << " defecated " << a << ".\n";
    }
};

int main() {
    vector<unique_ptr<anus>> anuses;

    anuses.push_back(make_unique<anus>("新北市"));
    anuses.push_back(make_unique<anus>("役政司替代役訓練暨管理中心"));
    anuses.push_back(make_unique<anus>("內政部戶政司與役政署"));

    vector<weak_ptr<shit>> shits;

    auto a1 = make_shared<shit>("役男大亨Online", anuses[0].get());
    anuses[0]->shits.push_back(a1);
    shits.push_back(a1);

    auto a2 = make_shared<shit>("113年新北「青年，好險有你」計畫", anuses[0].get());
    anuses[0]->shits.push_back(a2);
    shits.push_back(a2);

    auto a3 = make_shared<shit>("戶役政管家app", anuses[2].get());
    anuses[2]->shits.push_back(a3);
    shits.push_back(a3);

    auto a4 = make_shared<shit>("113 年兵籍調查線上申報", anuses[1].get());
    anuses[1]->shits.push_back(a4);
    shits.push_back(a4);

    auto a5 = make_shared<shit>("新北市XX區公所信件", anuses[0].get());
    anuses[0]->shits.push_back(a5);
    shits.push_back(a5);

    if (auto a_ptr = shits[0].lock()) {
        a_ptr->linkTo.push_back(shits[3].lock());
        cout << a_ptr->name << " links to " << shits[3].lock()->name << "\n";
    }

    if (auto a_ptr = shits[3].lock()) {
        a_ptr->linkTo.push_back(shits[2].lock());
        cout << a_ptr->name << " links to " << shits[2].lock()->name << "\n";
    }

    if (auto a_ptr = shits[2].lock()) {
        a_ptr->linkTo.push_back(shits[0].lock());
        cout << a_ptr->name << " links to " << shits[0].lock()->name << "\n";
    }

    if (auto a_ptr = shits[4].lock()) {
        a_ptr->linkTo.push_back(shits[0].lock());
        cout << a_ptr->name << " links to " << shits[0].lock()->name << "\n";
        a_ptr->linkTo.push_back(shits[1].lock());
        cout << a_ptr->name << " links to " << shits[1].lock()->name << "\n";
        a_ptr->linkTo.push_back(shits[2].lock());
        cout << a_ptr->name << " links to " << shits[2].lock()->name << "\n";
        a_ptr->linkTo.push_back(shits[3].lock());
        cout << a_ptr->name << " links to " << shits[3].lock()->name << "\n";
    }

    cout << "Python.gc.collect()\n";
    cout << "Shits flushed down into the toilet.\n";

    return 0;
}
