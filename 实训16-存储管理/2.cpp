#include "lru_replacer.h"

LRUReplacer::LRUReplacer(size_t num_pages) { max_size_ = num_pages; }

LRUReplacer::~LRUReplacer() = default;

/**
 * @brief 使用LRU策略删除一个victim frame，这个函数能得到frame_id
 * @param[out] frame_id id of frame that was removed, nullptr if no victim was found
 * @return true if a victim frame was found, false otherwise
 */
bool LRUReplacer::Victim(frame_id_t *frame_id) {
    std::scoped_lock lock{latch_};
    if(this->LRUlist_.empty()){
        return false;
    }
    else{
        *frame_id = this->LRUlist_.back();
        this->LRUlist_.pop_back();
        this->LRUhash_.erase(*frame_id);
        return true;
    }

}

void LRUReplacer::Pin(frame_id_t frame_id) {
    std::scoped_lock lock{latch_};
    auto find = this->LRUhash_.find(frame_id);
    if(find != this->LRUhash_.end()){
        this->LRUlist_.erase(find->second);
        this->LRUhash_.erase(find);
    }

}
void LRUReplacer::Unpin(frame_id_t frame_id) {
    std::scoped_lock lock{latch_};

    auto find = LRUhash_.find(frame_id);
    if(find == LRUhash_.end()) {
        LRUlist_.push_front(frame_id);
        LRUhash_[frame_id] = LRUlist_.begin();
    }

}

size_t LRUReplacer::Size() {
    return this->LRUlist_.size();
}

