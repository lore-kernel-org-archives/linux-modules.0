Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6760C7EE2E
	for <linux-modules@archiver.kernel.org>; Tue, 30 May 2023 08:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjE3Iw3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 30 May 2023 04:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjE3Iw2 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 30 May 2023 04:52:28 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069F7AB;
        Tue, 30 May 2023 01:52:26 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1q3v5c-000XjJ-BX; Tue, 30 May 2023 10:52:24 +0200
Received: from p57bd9d78.dip0.t-ipconnect.de ([87.189.157.120] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1q3v5c-003uII-3z; Tue, 30 May 2023 10:52:24 +0200
Message-ID: <c4ff8fe412eafd30aaed61a29940ac9527f0f7a3.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] module: fix module load for ia64
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Song Liu <song@kernel.org>, linux-modules@vger.kernel.org,
        linux-ia64@vger.kernel.org
Cc:     debian-ia64@lists.debian.org, mcgrof@kernel.org,
        Frank Scheiner <frank.scheiner@web.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 30 May 2023 10:52:23 +0200
In-Reply-To: <20230528230041.2592309-1-song@kernel.org>
References: <20230528230041.2592309-1-song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.1 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.157.120
X-ZEDAT-Hint: PO
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Sun, 2023-05-28 at 16:00 -0700, Song Liu wrote:
> Frank reported boot regression in ia64 as:
> 
> ELILO v3.16 for EFI/IA-64
> ..
> Uncompressing Linux... done
> Loading file AC100221.initrd.img...done
> [    0.000000] Linux version 6.4.0-rc3 (root@x4270) (ia64-linux-gcc
> (GCC) 12.2.0, GNU ld (GNU Binutils) 2.39) #1 SMP Thu May 25 15:52:20
> CEST 2023
> [    0.000000] efi: EFI v1.1 by HP
> [    0.000000] efi: SALsystab=0x3ee7a000 ACPI 2.0=0x3fe2a000
> ESI=0x3ee7b000 SMBIOS=0x3ee7c000 HCDP=0x3fe28000
> [    0.000000] PCDP: v3 at 0x3fe28000
> [    0.000000] earlycon: uart8250 at MMIO 0x00000000f4050000 (options
> '9600n8')
> [    0.000000] printk: bootconsole [uart8250] enabled
> [    0.000000] ACPI: Early table checksum verification disabled
> [    0.000000] ACPI: RSDP 0x000000003FE2A000 000028 (v02 HP    )
> [    0.000000] ACPI: XSDT 0x000000003FE2A02C 0000CC (v01 HP     rx2620
> 00000000 HP   00000000)
> [...]
> [    3.793350] Run /init as init process
> Loading, please wait...
> Starting systemd-udevd version 252.6-1
> [    3.951100] ------------[ cut here ]------------
> [    3.951100] WARNING: CPU: 6 PID: 140 at kernel/module/main.c:1547
> __layout_sections+0x370/0x3c0
> [    3.949512] Unable to handle kernel paging request at virtual address
> 1000000000000000
> [    3.951100] Modules linked in:
> [    3.951100] CPU: 6 PID: 140 Comm: (udev-worker) Not tainted 6.4.0-rc3 #1
> [    3.956161] (udev-worker)[142]: Oops 11003706212352 [1]
> [    3.951774] Hardware name: hp server rx2620                   , BIOS
> 04.29
> 11/30/2007
> [    3.951774]
> [    3.951774] Call Trace:
> [    3.958339] Unable to handle kernel paging request at virtual address
> 1000000000000000
> [    3.956161] Modules linked in:
> [    3.951774]  [<a0000001000156d0>] show_stack.part.0+0x30/0x60
> [    3.951774]                                 sp=e000000183a67b20
> bsp=e000000183a61628
> [    3.956161]
> [    3.956161]
> 
> which bisect to module_memory change [1].
> 
> Debug showed that ia64 uses some special sections:
> 
> __layout_sections: section .got (sh_flags 10000002) matched to MOD_INVALID
> __layout_sections: section .sdata (sh_flags 10000003) matched to MOD_INVALID
> __layout_sections: section .sbss (sh_flags 10000003) matched to MOD_INVALID
> 
> All these sections are loaded to module core memory before [1].
> 
> Fix ia64 boot by loading these sections to MOD_DATA (core rw data).
> 
> [1] commit ac3b43283923 ("module: replace module_layout with module_memory")
> 
> Fixes: ac3b43283923 ("module: replace module_layout with module_memory")
> Reported-by: Frank Scheiner <frank.scheiner@web.de>
> Closes: https://lists.debian.org/debian-ia64/2023/05/msg00010.html
> Closes: https://marc.info/?l=linux-ia64&m=168509859125505
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  kernel/module/main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index b4c7e925fdb0..9da4b551321e 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -1521,14 +1521,14 @@ static void __layout_sections(struct module *mod, struct load_info *info, bool i
>  		MOD_RODATA,
>  		MOD_RO_AFTER_INIT,
>  		MOD_DATA,
> -		MOD_INVALID,	/* This is needed to match the masks array */
> +		MOD_DATA,
>  	};
>  	static const int init_m_to_mem_type[] = {
>  		MOD_INIT_TEXT,
>  		MOD_INIT_RODATA,
>  		MOD_INVALID,
>  		MOD_INIT_DATA,
> -		MOD_INVALID,	/* This is needed to match the masks array */
> +		MOD_INIT_DATA,
>  	};
>  
>  	for (m = 0; m < ARRAY_SIZE(masks); ++m) {

I can confirm that this fixes module loading on my RX2660 with 6.4-rc4.

Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
