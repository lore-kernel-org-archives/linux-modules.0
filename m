Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947A6C433DB
	for <linux-modules@archiver.kernel.org>; Mon, 28 Dec 2020 15:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6156A20829
	for <linux-modules@archiver.kernel.org>; Mon, 28 Dec 2020 15:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393223AbgL1Pzy (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 28 Dec 2020 10:55:54 -0500
Received: from mxout02.lancloud.ru ([45.84.86.82]:47306 "EHLO
        mxout02.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393219AbgL1Pzs (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 28 Dec 2020 10:55:48 -0500
X-Greylist: delayed 379 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Dec 2020 10:55:43 EST
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout02.lancloud.ru BBBF622EFAC7
Received: from LanCloud
Received: from LanCloud
Subject: Wrong __setup() callbacks return values and /init's environment
 pollution
References: <64644a2f-4a20-bab3-1e15-3b2cdd0defe3@omprussia.ru>
To:     linux-modules <linux-modules@vger.kernel.org>
From:   Igor Zhbanov <i.zhbanov@omprussia.ru>
X-Forwarded-Message-Id: <64644a2f-4a20-bab3-1e15-3b2cdd0defe3@omprussia.ru>
Message-ID: <2023187f-5643-1acb-4fb4-433fbeb997ee@omprussia.ru>
Date:   Mon, 28 Dec 2020 18:48:43 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <64644a2f-4a20-bab3-1e15-3b2cdd0defe3@omprussia.ru>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To LFEX15.lancloud.ru
 (fd00:f066::45)
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

It seems that nobody knows how to write __setup() callback functions for
parsing the command line parameters. And there are no documentation or
comments about best practices.

Despite being declared obsolete __setup() is used about 435 times in the
kernel and 51 of them (~11.2%) are erroneous in the sense of returning
incorrect value (0) resulting in the /init process environment pollution.

Initially it was mentioned that the callback function should return 1 when
the parameter value is parsed and consumed successfully, or return 0 to
keep the unparsed option as init's environment variable.

But there are no comments or documentation about it, so developers often
always returning 0 (as it is typically expected in other kernel functions)
or returning -EINVAL on parse error. All these cases resulting in init's
environment pollution (which is limited only to 32 variables in the config).

Even the original usage when 0 is returned on the parse error is questionable
now. There are no (or not so many) parameter names clashes between different
kernel subsystems, as well as there not so many parameters to be passed to
init/systemd that could be interpreted as the kernel parameters. So if a
kernel module sure that this is its own parameter, may be it would be better
to always return 1 and consume it, even it is malformed.

Also there are no recommendations on whether to print a warning when
incorrect parameter is passed. Some of the functions print a warning on
incorrect values; some are silently proceeding with the default values.
Some are even calling panic() on incorrect parameters (e.g.
setup_time_travel() -> time_travel_connect_external()). So there is no
consistency on what behavior for handling incorrect parameters values are
recommended.

I've tried to categorize all of the __setup() usages. And here is the zoo:

Functions always returning 1 (right):
   (About 324)

Functions returning 0 on error, 1 on success (mostly right):
   arch/arm/mach-pxa/viper.c:__setup("tpm=", viper_tpm_setup);
   arch/arm/mach-omap1/i2c.c:__setup("i2c_bus=", omap_i2c_bus_setup);
   arch/powerpc/platforms/pseries/lpar.c:__setup("cmo_free_hint=", cmo_free_hint);
   arch/powerpc/sysdev/fsl_85xx_l2ctlr.c:__setup("cache-sram-size=", get_size_from_cmdline);
   arch/powerpc/sysdev/fsl_85xx_l2ctlr.c:__setup("cache-sram-offset=", get_offset_from_cmdline);
   arch/powerpc/kernel/iommu.c:__setup("fail_iommu=", setup_fail_iommu);
   arch/powerpc/kernel/rtasd.c:__setup("surveillance=", surveillance_setup);
   arch/powerpc/kernel/rtasd.c:__setup("rtasmsgs=", rtasmsgs_setup);
   arch/x86/kernel/cpu/mce/core.c:__setup("mce", mcheck_enable);
   arch/x86/kernel/cpu/common.c:__setup("nofsgsbase", x86_nofsgsbase_setup);
   arch/microblaze/kernel/traps.c:__setup("kstack=", kstack_setup);
   arch/c6x/kernel/soc.c:__setup("emac_addr=", get_mac_addr_from_cmdline);
   arch/sparc/kernel/apc.c:__setup("apc=", apc_setup);
   arch/um/drivers/stdio_console.c:__setup("con", console_chan_setup);
   net/ipv4/tcp_metrics.c:__setup("tcpmhash_entries=", set_tcpmhash_entries);
   net/ipv4/tcp.c:__setup("thash_entries=", set_thash_entries);
   net/ipv4/udp.c:__setup("uhash_entries=", set_uhash_entries);
   net/ipv4/ipconfig.c:__setup("carrier_timeout=", set_carrier_timeout);
   net/ethernet/eth.c:__setup("ether=", netdev_boot_setup);
   net/core/dev.c:__setup("netdev=", netdev_boot_setup);
   drivers/acpi/osl.c:__setup("acpi_enforce_resources=", acpi_enforce_resources_setup);
   drivers/scsi/BusLogic.c:__setup("BusLogic=", blogic_setup);
   drivers/scsi/mac_scsi.c:__setup("mac5380=", mac_scsi_setup);
   drivers/scsi/atari_scsi.c:__setup("atascsi=", atari_scsi_setup);
   drivers/net/arcnet/com90io.c:__setup("com90io=", com90io_setup);
   drivers/net/appletalk/ltpc.c:__setup("ltpc=", ltpc_setup);
   drivers/net/hamradio/baycom_par.c:__setup("baycom_par=", baycom_par_setup);
   drivers/net/hamradio/baycom_ser_hdx.c:__setup("baycom_ser_hdx=", baycom_ser_hdx_setup);
   drivers/net/hamradio/baycom_epp.c:__setup("baycom_epp=", baycom_epp_setup);
   drivers/net/hamradio/baycom_ser_fdx.c:__setup("baycom_ser_fdx=", baycom_ser_fdx_setup);
   drivers/video/console/mdacon.c:__setup("mdacon=", mdacon_setup);
   drivers/md/md-autodetect.c:__setup("md=", md_setup);
   drivers/block/amiflop.c:__setup("floppy=", amiga_floppy_setup);
   drivers/block/floppy.c:__setup("floppy=", floppy_setup);
   drivers/block/ataflop.c:__setup("floppy=", atari_floppy_setup);
   drivers/char/lp.c:__setup("lp=", lp_setup);
   mm/failslab.c:__setup("failslab=", setup_failslab);
   mm/huge_memory.c:__setup("transparent_hugepage=", setup_transparent_hugepage);
   mm/hugetlb.c:__setup("hugepages=", hugepages_setup);
   mm/hugetlb.c:__setup("hugepagesz=", hugepagesz_setup);
   mm/hugetlb.c:__setup("default_hugepagesz=", default_hugepagesz_setup);
   mm/page_alloc.c:__setup("hashdist=", set_hashdist);
   mm/mempolicy.c:__setup("numa_balancing=", setup_numabalancing);
   fs/namespace.c:__setup("mhash_entries=", set_mhash_entries);
   fs/namespace.c:__setup("mphash_entries=", set_mphash_entries);
   fs/dcache.c:__setup("dhash_entries=", set_dhash_entries);
   fs/inode.c:__setup("ihash_entries=", set_ihash_entries);
   init/do_mounts.c:__setup("ro", readonly);
   init/do_mounts.c:__setup("rw", readwrite);
   init/do_mounts.c:__setup("rootwait", rootwait_setup);
   init/initramfs.c:__setup("retain_initrd", retain_initrd_param);
   lib/dynamic_debug.c:__setup("ddebug_query=", ddebug_setup_query);
   kernel/sched/core.c:__setup("schedstats=", setup_schedstats);
   kernel/sched/isolation.c:__setup("nohz_full=", housekeeping_nohz_full_setup);
   kernel/sched/isolation.c:__setup("isolcpus=", housekeeping_isolcpus_setup);
   kernel/gcov/fs.c:__setup("gcov_persist=", gcov_persist_setup);
   kernel/trace/ftrace.c:__setup("ftrace_graph_max_depth=", set_graph_max_depth_function);
   kernel/trace/trace.c:__setup("ftrace_dump_on_oops", set_ftrace_dump_on_oops);
   kernel/trace/trace.c:__setup("trace_buf_size=", set_buf_size);
   kernel/trace/trace.c:__setup("tracing_thresh=", set_tracing_thresh);
   sound/oss/dmasound/dmasound_core.c:__setup("dmasound=", dmasound_setup);

Functions always returning 0 (wrong):
   arch/arm/mach-s3c/mach-jive.c:__setup("mtdset=", jive_mtdset);
   arch/powerpc/platforms/4xx/cpm.c:__setup("powersave=off", cpm_powersave_off);
   arch/powerpc/sysdev/xive/common.c:__setup("xive=off", xive_off);
   arch/powerpc/kernel/idle.c:__setup("powersave=off", powersave_off);
   arch/x86/entry/vdso/vma.c:__setup("vdso=", vdso_setup);
   arch/x86/platform/goldfish/goldfish.c:__setup("goldfish", goldfish_setup);
   arch/x86/mm/pat/memtype.c:__setup("debugpat", pat_debug_setup);
   arch/x86/kernel/apic/apic.c:__setup("apicpmtimer", setup_apicpmtimer);
   arch/x86/kernel/cpu/intel.c:__setup("ring3mwait=disable", ring3mwait_disable);
   arch/x86/kernel/sys_x86_64.c:__setup("align_va_addr", control_va_addr_alignment);
   arch/sh/kernel/nmi_debug.c:__setup("nmi_debug", nmi_debug_setup);
   arch/sparc/kernel/nmi.c:__setup("nmi_watchdog=", setup_nmi_watchdog);
   drivers/acpi/apei/erst.c:__setup("erst_disable", setup_erst_disable);
   drivers/acpi/apei/bert.c:__setup("bert_disable", setup_bert_disable);
   drivers/acpi/apei/hest.c:__setup("hest_disable", setup_hest_disable);
   drivers/base/dd.c:__setup("driver_async_probe=", save_async_options);
   drivers/net/wan/sbni.c:__setup( "sbni=", sbni_setup );
   drivers/firmware/efi/apple-properties.c:__setup("dump_apple_properties", dump_properties_enable);
   security/integrity/evm/evm_main.c:__setup("evm=", evm_set_fixmode);
   security/tomoyo/load_policy.c:__setup("TOMOYO_loader=", tomoyo_loader_setup);
   security/tomoyo/load_policy.c:__setup("TOMOYO_trigger=", tomoyo_trigger_setup);
   mm/memcontrol.c:__setup("cgroup.memory=", cgroup_memory);
   mm/mmap.c:__setup("stack_guard_gap=", cmdline_parse_stack_guard_gap);
   init/main.c:__setup("initcall_blacklist=", initcall_blacklist);
   kernel/power/suspend_test.c:__setup("test_suspend", setup_test_suspend);
   kernel/trace/trace_kprobe.c:__setup("kprobe_event=", set_kprobe_boot_events);
   kernel/trace/trace.c:__setup("trace_options=", set_trace_boot_options);
   kernel/trace/trace.c:__setup("trace_clock=", set_trace_boot_clock);

Functions returning 1 on error, 0 on success (wrong):
   drivers/scsi/aha152x.c:__setup("aha152x=", aha152x_setup);
   kernel/printk/printk.c:__setup("printk.devkmsg=", control_devkmsg);

Functions returning -errrno (-EINVAL mostly) on error, 0 on success (wrong):
   arch/x86/platform/intel-mid/intel-mid.c:__setup("x86_intel_mid_timer=", setup_x86_intel_mid_timer);
   arch/sparc/vdso/vma.c:__setup("vdso=", vdso_setup);
   arch/mips/rb532/devices.c:__setup("kmac=", setup_kmac);
   drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c:__setup("sxgbeeth=", sxgbe_cmdline_opt);
   drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:__setup("stmmaceth=", stmmac_cmdline_opt);
   drivers/tty/serial/kgdboc.c:__setup("kgdboc=", kgdboc_option_setup);
   drivers/tty/hvc/hvc_iucv.c:__setup("hvc_iucv=", hvc_iucv_config);
   drivers/misc/kgdbts.c:__setup("kgdbts=", kgdbts_option_setup);
   drivers/iommu/intel/iommu.c:__setup("intel_iommu=", intel_iommu_setup);
   drivers/firmware/efi/efi.c:__setup("efivar_ssdt=", efivar_ssdt_setup);
   mm/usercopy.c:__setup("hardened_usercopy=", parse_hardened_usercopy);
   init/main.c:__setup("rodata=", set_debug_rodata);
   kernel/dma/debug.c:__setup("dma_debug=", dma_debug_cmdline);
   kernel/dma/debug.c:__setup("dma_debug_entries=", dma_debug_entries_cmdline);

Functions returning -EINVAL on error, 1 on success (wrong):
   arch/um/kernel/time.c:__setup("time-travel", setup_time_travel);
   arch/um/kernel/time.c:__setup("time-travel-start", setup_time_travel_start);
   drivers/clocksource/acpi_pm.c:__setup("pmtmr=", parse_pmtmr);
   drivers/acpi/sysfs.c:__setup("acpi_mask_gpe=", acpi_gpe_set_masked_gpes);
   kernel/power/hibernate.c:__setup("resumedelay=", resumedelay_setup);

Functions that don't have the return statement at all (wrong):
   arch/arm/mm/mmu.c:early_param("cachepolicy", early_cachepolicy);
   arch/arm/mm/mmu.c:__setup("noalign", noalign_setup);

So it would be better to document at least how a __setup() callback handler
should behave regarding the return value, whether to print a warning on parse
error. And the functions not returning 0 on error and 1 on success must be
fixed.

Also to avoid init's processes pollution may be it is even better to simply
always returning 1 even on parse errors, because parameters names collisions
are very infrequent.

P.S. Tried to send to LKML with no luck.
