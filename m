Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81933211299
	for <linux-modules@vger.kernel.org>; Thu, 13 Feb 2025 09:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739437789; cv=none; b=rJ9/e/Y3fJQde/WvoJ2RnzKSrTYQwokN+/qZ7DcWD2Ea3uLGnUp/5bEs0xMm1Ddx18NlaFbCAnHOTsOgQWx/oHB06HtY+xm2YEw2p6Xs8p5Nm6Qn1LJifMsdXBYmdktlThPRo4pRXLdZmua7yiWkFE6DxJifHSDJ39ckwz9/dVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739437789; c=relaxed/simple;
	bh=yIofNp3DOnt44hzmtEVn7QWYrlSOhhx9bqOniqpFPVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=tmJrZynZhMczIbKkbi8DWqJooFMiHzUVAAM7cx2fHIw9cg4fs8KAjFZSR3eifrJ99xMKm7OYf+wR5sLjG2LftD68YBSpRneyQ3bTAnIqADNiAW3Qh0atuvlGaPkMiaYABvNQoxEdCyXtzTpY32EULR2rpXqkKHUe1ifihfdATo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=F2euJgpp; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="F2euJgpp"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ab7483b9bf7so74638766b.3
        for <linux-modules@vger.kernel.org>; Thu, 13 Feb 2025 01:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739437785; x=1740042585; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xs0dMv8Lg47llTTsTqc4aG+TvIPsuFrqAsJa4mSZy7s=;
        b=F2euJgpp4YTqZUodflHiB4s/i48Vmhmi2JlmW9jAOX30OqqD6CsjV0DMBbnUVwHnkk
         qnNp+7G8HPy8m32zM/bEnL2lc4WyWI6VvTMQPq9YQh04F/MqhK4PW5O/BNb4EMbjzpTc
         moyJJZntr9VQ4Cfl9cDDXQzIzg7yZSCgzeGus74Ivq0j3gZ4Fpd1T4T+++QwtJ6ox+yU
         qZjEEI6w+mfzK/qI4Mw+k9KVATGi761jCQmogCdJAb+ZUMvaxOQda4HM7vdS4DvtXawu
         V/d5vj9NrJdvj9IwPMDQQErFPUR4DpSTEZhaS2eSpTjBmBkFAK7+KOjUHxTN6lBwdFyd
         m6Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739437785; x=1740042585;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xs0dMv8Lg47llTTsTqc4aG+TvIPsuFrqAsJa4mSZy7s=;
        b=EvsitpQaSX+W64CPBQHQmN2czatfNrzqXBiqDYWaDG5S67aPzfzu7hzRLG+kppEDeq
         NNFT2yKOdUfuPZu5X1osacMaQrk7zNMX0GJPqntd6VM5L7r1UM+2fmX1hXR/t8vWczaa
         RMeblB6dWl7ufUqppFWJF87XwsgT0sWC6cdWt0MBTLl81Pt9eiQD7v8r1fcTTSf8gJk4
         m09htUeJK7xx+YX3BGX2YA5F3VDI8Zc1b3wW1YL/kBYZWHCLo/224pRVjAAyPpHg2FMh
         Z5P9s0mwG9Gmh2YDxpcPU3QxAYmL0unaMLtdrTqBdH2hntGoKiTe+ItrMd6XBiOEHjdN
         BrPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXr6LA1uvQ73VBOZbylHeLt8I83FgaiRK+1HsAknnqZ6jaFjPpv1aYKpNK3s0JXZ0awj0g7FzXhwNg5ffDh@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3/0sTEZKeTrogPEtfm1A9oxItdS4HGqh54OhZkEa0pgnAl/eg
	qMBz0OvchtO/Bzh54ZPSOi7pP+c2203qHUxN7rICUtr3hEqZQHTUwcVKn7Et9BM=
X-Gm-Gg: ASbGncvBz+LgLnqiKDab69Wc6cJRjWKy4rXwkudfAtsZDrDhTtTDx07LdXirzjIft+W
	L5tUXwkXJCnp+y1/emZdgNMohDVgUHiOvICYGfMRYvT5Dg5NYYE2Mkd3qbHQuzjIvuLRIcEG3Sm
	MUc+5gqBafWMfxfjy/EqzeT/DvQx4M5CPyTT2HLDb1DetNolYMSCTS+vuGVbZa6EdFko7mYb59Y
	dJAp6O2SxkZ1bGXAR2a33Fn73Ox+7HhGDAxg2pofFuFTHeWXx4JQs8lBDDftxxHMpNkRdYmleJB
	fwj424k+Nlw78FE/fSw=
X-Google-Smtp-Source: AGHT+IFfQRdWjBtuKVsNwvUqDft33DU0Ymv+Yih3Ck/9OfZla4U74TcMTKYM4uEfh0wH5+ykvybEyA==
X-Received: by 2002:a17:907:6d29:b0:ab7:e91c:77e5 with SMTP id a640c23a62f3a-ab7f334447emr670362566b.11.1739437785520;
        Thu, 13 Feb 2025 01:09:45 -0800 (PST)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba5339d96dsm89457866b.153.2025.02.13.01.09.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 01:09:45 -0800 (PST)
Message-ID: <ba4e7509-cab5-4987-ba2e-4a00eebcc348@suse.com>
Date: Thu, 13 Feb 2025 10:09:44 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [modules?] KMSAN: uninit-value in __request_module (6)
To: da.gomez@samsung.com, linux-modules@vger.kernel.org, mcgrof@kernel.org,
 samitolvanen@google.com
References: <67aca50a.050a0220.110943.004e.GAE@google.com>
Content-Language: en-US
Cc: syzbot <syzbot+1fcd957a82e3a1baa94d@syzkaller.appspotmail.com>,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <67aca50a.050a0220.110943.004e.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/12/25 14:41, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    febbc555cf0f Merge tag 'nfsd-6.14-1' of git://git.kernel.o..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=137a78e4580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=48f90cac5eea091a
> dashboard link: https://syzkaller.appspot.com/bug?extid=1fcd957a82e3a1baa94d
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=177a78e4580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16adc3f8580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/f90f94285615/disk-febbc555.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/b8a8bb66806c/vmlinux-febbc555.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/c8af6c511559/bzImage-febbc555.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+1fcd957a82e3a1baa94d@syzkaller.appspotmail.com
> 
> =====================================================
> BUG: KMSAN: uninit-value in string_nocheck lib/vsprintf.c:633 [inline]
> BUG: KMSAN: uninit-value in string+0x3ec/0x5f0 lib/vsprintf.c:714
>  string_nocheck lib/vsprintf.c:633 [inline]
>  string+0x3ec/0x5f0 lib/vsprintf.c:714
>  vsnprintf+0xa5d/0x1960 lib/vsprintf.c:2843
>  __request_module+0x252/0x9f0 kernel/module/kmod.c:149
>  team_mode_get drivers/net/team/team_core.c:480 [inline]
>  team_change_mode drivers/net/team/team_core.c:607 [inline]
>  team_mode_option_set+0x437/0x970 drivers/net/team/team_core.c:1401
>  team_option_set drivers/net/team/team_core.c:375 [inline]
>  team_nl_options_set_doit+0x1339/0x1f90 drivers/net/team/team_core.c:2661
>  genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
>  genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
>  genl_rcv_msg+0x1214/0x12c0 net/netlink/genetlink.c:1210
>  netlink_rcv_skb+0x375/0x650 net/netlink/af_netlink.c:2543
>  genl_rcv+0x40/0x60 net/netlink/genetlink.c:1219
>  netlink_unicast_kernel net/netlink/af_netlink.c:1322 [inline]
>  netlink_unicast+0xf52/0x1260 net/netlink/af_netlink.c:1348
>  netlink_sendmsg+0x10da/0x11e0 net/netlink/af_netlink.c:1892
>  sock_sendmsg_nosec net/socket.c:718 [inline]
>  __sock_sendmsg+0x30f/0x380 net/socket.c:733
>  ____sys_sendmsg+0x877/0xb60 net/socket.c:2573
>  ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2627
>  __sys_sendmsg net/socket.c:2659 [inline]
>  __do_sys_sendmsg net/socket.c:2664 [inline]
>  __se_sys_sendmsg net/socket.c:2662 [inline]
>  __x64_sys_sendmsg+0x212/0x3c0 net/socket.c:2662
>  x64_sys_call+0x2ed6/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:47
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Uninit was created at:
>  slab_post_alloc_hook mm/slub.c:4121 [inline]
>  slab_alloc_node mm/slub.c:4164 [inline]
>  kmem_cache_alloc_node_noprof+0x907/0xe00 mm/slub.c:4216
>  kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:587
>  __alloc_skb+0x363/0x7b0 net/core/skbuff.c:678
>  alloc_skb include/linux/skbuff.h:1331 [inline]
>  netlink_alloc_large_skb+0x1b4/0x280 net/netlink/af_netlink.c:1196
>  netlink_sendmsg+0xa96/0x11e0 net/netlink/af_netlink.c:1867
>  sock_sendmsg_nosec net/socket.c:718 [inline]
>  __sock_sendmsg+0x30f/0x380 net/socket.c:733
>  ____sys_sendmsg+0x877/0xb60 net/socket.c:2573
>  ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2627
>  __sys_sendmsg net/socket.c:2659 [inline]
>  __do_sys_sendmsg net/socket.c:2664 [inline]
>  __se_sys_sendmsg net/socket.c:2662 [inline]
>  __x64_sys_sendmsg+0x212/0x3c0 net/socket.c:2662
>  x64_sys_call+0x2ed6/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:47
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> CPU: 0 UID: 0 PID: 5814 Comm: syz-executor989 Not tainted 6.14.0-rc2-syzkaller-00034-gfebbc555cf0f #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
> =====================================================

For the record in linux-modules, Eric Dumazet posted a fix for this
issue at:
https://lore.kernel.org/netdev/20250212134928.1541609-1-edumazet@google.com/

-- Petr
