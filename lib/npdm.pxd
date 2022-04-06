#  PXDGEN IMPORTS
from libc.stdint cimport uint32_t
from .cJSON cimport cJSON
from libc.stdint cimport uint16_t
from libc.stdint cimport uint8_t
from libc.stdint cimport uint64_t
from .settings cimport hactool_ctx_t

cdef extern from "npdm.h":
    struct kac_mmio:
        uint64_t address
        uint64_t size
        int is_ro
        int is_norm
        kac_mmio* next
    ctypedef kac_mmio kac_mmio_t
    struct kac_irq:
        uint32_t irq0
        uint32_t irq1
        kac_irq* next
    ctypedef kac_irq kac_irq_t
    ctypedef struct kac_t:
        int has_kern_flags
        uint32_t lowest_thread_prio
        uint32_t highest_thread_prio
        uint32_t lowest_cpu_id
        uint32_t highest_cpu_id
        uint8_t svcs_allowed[128]
        kac_mmio_t* mmio
        kac_irq_t* irqs
        int has_app_type
        uint32_t application_type
        int has_kern_ver
        uint32_t kernel_release_version
        int has_handle_table_size
        uint32_t handle_table_size
        int has_debug_flags
        int allow_debug
        int force_debug
    struct sac_entry:
        char service[17]
        int valid
        sac_entry* next
    ctypedef sac_entry sac_entry_t
    ctypedef struct fac_t:
        uint32_t version
        uint64_t perms
        uint8_t _0xC[32]
    ctypedef struct fah_t:
        uint32_t version
        uint64_t perms
        uint32_t _0xC
        uint32_t _0x10
        uint32_t _0x14
        uint32_t _0x18
    ctypedef struct fs_perm_t:
        const char* name
        uint64_t mask
    ctypedef struct npdm_aci0_t:
        uint32_t magic
        uint8_t _0x4[12]
        uint64_t title_id
        uint64_t _0x18
        uint32_t fah_offset
        uint32_t fah_size
        uint32_t sac_offset
        uint32_t sac_size
        uint32_t kac_offset
        uint32_t kac_size
        uint64_t padding
    ctypedef struct npdm_acid_t:
        uint8_t signature[256]
        uint8_t modulus[256]
        uint32_t magic
        uint32_t size
        uint32_t _0x208
        uint32_t flags
        uint64_t title_id_range_min
        uint64_t title_id_range_max
        uint32_t fac_offset
        uint32_t fac_size
        uint32_t sac_offset
        uint32_t sac_size
        uint32_t kac_offset
        uint32_t kac_size
        uint64_t padding
    ctypedef struct npdm_t:
        uint32_t magic
        uint32_t acid_sign_key_index
        uint32_t _0x8
        uint8_t mmu_flags
        uint8_t _0xD
        uint8_t main_thread_prio
        uint8_t default_cpuid
        uint64_t _0x10
        uint32_t version
        uint32_t main_stack_size
        char title_name[80]
        uint32_t aci0_offset
        uint32_t aci0_size
        uint32_t acid_offset
        uint32_t acid_size
    npdm_acid_t* npdm_get_acid(npdm_t* npdm)
    npdm_aci0_t* npdm_get_aci0(npdm_t* npdm)
    void npdm_process(npdm_t* npdm, hactool_ctx_t* tool_ctx)
    void npdm_print(npdm_t* npdm, hactool_ctx_t* tool_ctx)
    void npdm_save(npdm_t* npdm, hactool_ctx_t* tool_ctx)
    const char* npdm_get_proc_category(int process_category)
    void kac_print(const uint32_t* descriptors, uint32_t num_descriptors)
    char* npdm_get_json(npdm_t* npdm)
    void cJSON_AddU8ToObject(cJSON* obj, const char* name, uint8_t val)
    void cJSON_AddU16ToObject(cJSON* obj, const char* name, uint16_t val)
    void cJSON_AddU32ToObject(cJSON* obj, const char* name, uint32_t val)
    void cJSON_AddU64ToObject(cJSON* obj, const char* name, uint64_t val)
    cJSON* kac_get_json(const uint32_t* descriptors, uint32_t num_descriptors)


