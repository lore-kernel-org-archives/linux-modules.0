Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B10FC07E9B
	for <linux-modules@archiver.kernel.org>; Wed,  7 Jul 2021 14:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57B5E61CC3
	for <linux-modules@archiver.kernel.org>; Wed,  7 Jul 2021 14:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbhGGO7O (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 7 Jul 2021 10:59:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:60946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232116AbhGGO7K (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Wed, 7 Jul 2021 10:59:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C58F461CC1;
        Wed,  7 Jul 2021 14:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625669777;
        bh=mZlhhZqeW09Vj7/kX6yaOIrSDsUaAchfHq9x6tXQsu0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pJluxDGIpDj9upDrde8aBrq6Udfmu59DcHqXLV33j+727K5mVOwcyQYxT4jPAKRmY
         /E9f/R8zx/lcv96kFquQElqgDiDHmrXCNHPbLfedS1Ug82JpWxELBvNyzqQ2RSUMHz
         lctaYj6v01NWz5zS/lAiJQ4Pvx2AJaKKffuZ+RkRPCo/ezq8bqFnBZ8iIHHqjplmN9
         dgxXIofarEezb1SF40kFx7aqkgO3nnNjy//W7/wT3C4YnoIZO26Lgoxo5GePEmNG/8
         YhH8qooWdSWvj6dSEDStWSU+5C8ptlKW3EYN4jBrXLXw0PBvGldTlj+3uLHjeonc2D
         qdm7ZJ5d7OdGw==
Date:   Wed, 7 Jul 2021 16:56:12 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     masahiroy@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        Eugene Loh <eugene.loh@oracle.com>,
        Kris Van Hees <kris.van.hees@oracle.com>
Subject: Re: [PATCH v2 PING] kallsyms: new /proc/kallmodsyms with builtin
 modules and symbol sizes
Message-ID: <YOXAjHC9RPAI5QwO@p200300cbcf044300404ca642de146c7c.dip0.t-ipconnect.de>
References: <20210629221542.93728-1-nick.alcock@oracle.com>
 <20210706193334.474270-1-nick.alcock@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210706193334.474270-1-nick.alcock@oracle.com>
X-OS:   Linux p200300cbcf044300404ca642de146c7c.dip0.t-ipconnect.de
 5.12.10-1-default x86_64
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

+++ Nick Alcock [06/07/21 20:33 +0100]:
>/proc/kallsyms is very useful for tracers and other tools that need to
>map kernel symbols to addresses.
>
>It would be useful if:
>
>- there were a mapping between kernel symbol and module name that only
>  changed when the kernel source code is changed.  This mapping should
>  not change simply because a module becomes built into the kernel.
>
>- there were symbol size information to determine whether an address is
>  within a symbol or outside it, especially given that there could be
>  huge gaps between symbols.
>
>Fix this by introducing a new config parameter CONFIG_KALLMODSYMS, which
>does several things at once.
>
>Change scripts/kallsyms.c stdin from "nm" to "nm -S" so that symbol
>sizes are available.  Have sort_symbols() incorporate size info.  Emit
>size info for each symbol into .kallsyms_sizes in the *.s output file.
>Change module_get_kallsym() to return symbol size as well.
>
>Generate a file "modules_thick.builtin" that maps from the thin archives
>that make up built-in modules to their constituent object files.  (This
>reintroduces the machinery that used to be used to generate
>modules.builtin.  I am not wedded to this mechanism: if someone can
>figure out a mechanism that does not require recursing over the entire
>build tree, I'm happy to use it, but I suspect that no such mechanism
>exists, since the only place the mapping from object file to module
>exists is in the makefiles themselves. Regardless, this is fairly cheap,
>adding less than a second to a typical hot-cache build of a large
>enterprise kernel.  This is true even though it needs to be run
>unconditionally whenever the .config changes.)
>
>Generate a linker map ".tmp_vmlinux.map", converting it into
>".tmp_vmlinux.ranges", mapping address ranges to object files.
>
>Have scripts/kallsyms read these two new files to map symbol addresses
>to built-in-module names and then write a mapping from object file
>address to module name to the *.s output file.
>
>The mapping consists of three new symbols:
>
> - .kallsyms_module_addresses/.kallsyms_module_offsets encodes the
>   address/offset of each object file (derived from the linker map), in
>   exactly the same way as .kallsyms_addresses/.kallsyms_offsets does
>   for symbols.  There is no size: instead, the object files are
>   assumed to tile the address space.  (This is slightly more
>   space-efficient than using a size).  Non-text-section addresses are
>   skipped: for now, all the users of this interface only need
>   module/non-module information for instruction pointer addresses, not
>   absolute-addressed symbols and the like.  This restriction can
>   easily be lifted in future.  (For why this isn't called
>   .kallsyms_objfiles, see two entries below.)
>
> - .kallsyms_module_names encodes the name of each module in a modified
>   form of strtab: notably, if an object file appears in *multiple*
>   modules, all of which are built in, this is encoded via a zero byte,
>   a one-byte module count, then a series of that many null-terminated
>   strings.  Object files which appear in only one module in such a
>   multi-module list are redirected to point inside that list, so that
>   modules which contain some object files shared with other modules
>   and some object files exclusive to them do not double up the module
>   name.  (There might still be some duplication between multiple
>   multi-module lists, but this is an extremely marginal size effect,
>   and resolving it would require an extra layer of lookup tables which
>   would be even more complex, and incompressible to boot).  As a
>   special case, the table starts with a single zero byte which does
>   *not* represent the start of a multi-module list.
>
> - .kallsyms_modules connects the two, encoding a table associated 1:1
>   with .kallsyms_module_addresses / kallsyms_module_offsets, pointing
>   at an offset in .kallsyms_module_names describing which module (or
>   modules, for a multi-module list) the code occupying this address
>   range is part of.  If an address range is part of no module (always
>   built-in) it points at 0 (the null byte at the start of the
>   .kallsyms_module_anmes list).  Entries in this list that would
>   contain the same value are fused together, along with their
>   corresponding .kallsyms_module_addresses/offsets entries.  Due to
>   this fusion process, and because object files can be split apart into
>   multiple parts by the linker for hot/cold partitioning and the like,
>   entries in here do not really correspond to an object file, but more
>   to some contiguous range of addresses which are guaranteed to belong
>   to a single built-in module: so it seems best to call the symbols
>   .kallsyms_modules*.  (The generator has a data structure that does
>   correspond more closely to object files, from which .kallsyms_modules
>   is generated, and that does use 'objfiles' terminology.)
>
>In kernel/kallsyms, use the new symbol size information in
>get_symbol_pos(), both to identify the correct symbol and to return
>correct size information.  Emit a new /proc/kallmodsyms file akin to
>/proc/kallsyms but with built-in-module names and symbol sizes, using a
>new kallsyms_builtin_module_address() almost identical to
>kallsyms_sym_address() to get the address corresponding to a given
>.kallsyms_modules index, and a new get_builtin_module_idx quite similar
>to get_symbol_pos to determine the index in the .kallsyms_modules array
>that relates to a given address.  Save a little time by exploiting the
>fact that all callers will only ever traverse this list from start to
>end by allowing them to pass in the previous index returned from this
>function as a hint: thus very few bsearches are actually needed.  (In
>theory this could change to just walk straight down
>kallsyms_module_addresses/offsets and not bother bsearching at all, but
>doing it this way is hardly any slower and much more robust.)
>
>The display process is complicated a little by the weird format of the
>.kallsyms_module_names table: we have to look for multimodule entries
>and print them as space-separated lists of module names.
>
>The resulting /proc/kallmodsyms file looks like this:
>    ffffffff8b013d20 409 t pt_buffer_setup_aux
>    ffffffff8b014130 11f T intel_pt_interrupt
>    ffffffff8b014250 2d T cpu_emergency_stop_pt
>    ffffffff8b014280 13a t rapl_pmu_event_init      [intel_rapl_perf]
>    ffffffff8b0143c0 bb t rapl_event_update [intel_rapl_perf]
>    ffffffff8b014480 10 t rapl_pmu_event_read       [intel_rapl_perf]
>    ffffffff8b014490 a3 t rapl_cpu_offline  [intel_rapl_perf]
>    ffffffff8b014540 24 t __rapl_event_show [intel_rapl_perf]
>    ffffffff8b014570 f2 t rapl_pmu_event_stop       [intel_rapl_perf]
>This is emitted even if intel_rapl_perf is built into the kernel.
>
>Further down, we see what happens when object files are reused by
>multiple modules, all of which are built in to the kernel:
>
>ffffffffa22b3aa0 ab t handle_timestamp  [liquidio]
>ffffffffa22b3b50 4a t free_netbuf       [liquidio]
>ffffffffa22b3ba0 8d t liquidio_ptp_settime      [liquidio]
>ffffffffa22b3c30 b3 t liquidio_ptp_adjfreq      [liquidio]
>[...]
>ffffffffa22b9490 203 t lio_vf_rep_create        [liquidio]
>ffffffffa22b96a0 16b t lio_vf_rep_destroy       [liquidio]
>ffffffffa22b9810 1f t lio_vf_rep_modinit        [liquidio]
>ffffffffa22b9830 1f t lio_vf_rep_modexit        [liquidio]
>ffffffffa22b9850 d2 t lio_ethtool_get_channels   [liquidio] [liquidio_vf]
>ffffffffa22b9930 9c t lio_ethtool_get_ringparam  [liquidio] [liquidio_vf]
>ffffffffa22b99d0 11 t lio_get_msglevel   [liquidio] [liquidio_vf]
>ffffffffa22b99f0 11 t lio_vf_set_msglevel        [liquidio] [liquidio_vf]
>ffffffffa22b9a10 2b t lio_get_pauseparam         [liquidio] [liquidio_vf]
>ffffffffa22b9a40 738 t lio_get_ethtool_stats     [liquidio] [liquidio_vf]
>ffffffffa22ba180 368 t lio_vf_get_ethtool_stats  [liquidio] [liquidio_vf]
>ffffffffa22ba4f0 37 t lio_get_regs_len   [liquidio] [liquidio_vf]
>ffffffffa22ba530 18 t lio_get_priv_flags         [liquidio] [liquidio_vf]
>ffffffffa22ba550 2e t lio_set_priv_flags         [liquidio] [liquidio_vf]
>ffffffffa22ba580 69 t lio_set_fecparam   [liquidio] [liquidio_vf]
>ffffffffa22ba5f0 92 t lio_get_fecparam   [liquidio] [liquidio_vf]
>[...]
>ffffffffa22cbd10 175 t liquidio_set_mac [liquidio_vf]
>ffffffffa22cbe90 ab t handle_timestamp  [liquidio_vf]
>ffffffffa22cbf40 4a t free_netbuf       [liquidio_vf]
>ffffffffa22cbf90 2b t octnet_link_status_change [liquidio_vf]
>ffffffffa22cbfc0 7e t liquidio_vxlan_port_command.constprop.0   [liquidio_vf]
>
>Like /proc/kallsyms, the output is driven by address, so keeps the
>curious property of /proc/kallsyms that symbols (like free_netbuf above)
>may appear repeatedly with different addresses: but now, unlike in
>/proc/kallsyms, we can see that those symbols appear repeatedly because
>they are *different symbols* that ultimately belong to different
>modules, all of which are built in to the kernel.
>
>Those symbols that come from object files that are genuinely reused and
>that appear only once in meory get a /proc/kallmodsyms line with
>[multiple] [modules] on it: consumers will have to be ready to handle
>such lines.
>
>Also, kernel symbols for built-in modules will probably appear
>interspersed with other symbols that are part of different modules and
>non-modular always-built-in symbols, which, as usual, have no
>square-bracketed module denotation.
>
>As with /proc/kallsyms, non-root usage produces addresses that are
>all zero; symbol sizes are treated similarly.
>
>The size impact of all of this is minimal: for the case above, the
>kallsyms2.S file went from 14107772 to 14137245 bytes, a gain of 29743
>bytes, or 0.16%: vmlinux gained 10824 bytes, a gain of .017%, and the
>compressed vmlinux only 7552 bytes, a gain of .08%: though the latter
>two values are very configuration-dependent, they seem likely to scale
>roughly with the kernel they are part of.
>
>Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
>Signed-off-by: Eugene Loh <eugene.loh@oracle.com>
>Reviewed-by: Kris Van Hees <kris.van.hees@oracle.com>
>---
> .gitignore                  |   1 +
> Documentation/dontdiff      |   1 +
> Makefile                    |  21 +-
> include/linux/module.h      |   7 +-
> init/Kconfig                |   8 +
> kernel/kallsyms.c           | 304 ++++++++++++++---
> kernel/module.c             |   4 +-
> scripts/Kbuild.include      |   6 +
> scripts/Makefile            |   6 +
> scripts/Makefile.modbuiltin |  56 ++++
> scripts/kallsyms.c          | 650 +++++++++++++++++++++++++++++++++++-
> scripts/kconfig/confdata.c  |  41 ++-
> scripts/link-vmlinux.sh     |  23 +-
> scripts/modules_thick.c     | 200 +++++++++++
> scripts/modules_thick.h     |  48 +++
> 15 files changed, 1309 insertions(+), 67 deletions(-)

This diffstat is seriously _enormous_. Please don't send patches of
this size and expect people to be willing to review :-(. Please break
this up into a logical sequence of smaller patches to help your
potential reviewers and resend with a cover letter.

Thanks,

Jessica
