Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF968285C89;
	Mon, 30 Jun 2025 12:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751285362; cv=none; b=RjzeQuegOmRXQ7lxvt8bRYNGOYFtDZzi/7yFmopKzOLcbrG4wmCQbsPPgAU5P8ZScPX80uu7WjGTUszCSgylMLv8U12QBsBVHBbN2sMmmfKk9DQ593fVp144DbSFeLCEciyQQDJFDJY2ewnUhlqPgvsr6zqxQg21T/goas0OkHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751285362; c=relaxed/simple;
	bh=mjcDggyNISX/qzUMVv+sNg50fc1cVis7bTvUTXsAkTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pjwW+FqQ+QlStQVeEGDE/lpcvoIgL8Lblbja/wqGR8iEpEemIgZsofhWYxBPVKrDnYH5WYdtUAgxeZK0gJR8Rlf8PiyH+K53GO/0nZHvNR2/gAS2Oc3u7WerOLLiBZHUA3fV/N9y2kFjXQhPNfZjwJ0r+28jlmuREV9cd8Vqe70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/F+EUkG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/F+EUkG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FFA7C4CEE3;
	Mon, 30 Jun 2025 12:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751285361;
	bh=mjcDggyNISX/qzUMVv+sNg50fc1cVis7bTvUTXsAkTY=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=b/F+EUkGv/BEQbbyjSsIGu3E4mwQlQ6Cr4RMdjl7EIQLShHOV4mIarsITKFSOSbkf
	 0VIV7rgrse6Be8VEq0hPkLNcfyC70yVpCen+wFg8ESCThGQzuwoNCLJgkRMzpo/Vk8
	 9aI7F9pPc0s23CPcaPO5Lqu6U2PM8zHKgDTRauu/Hy5+4eDyz72GLotl5qp+x9RfE/
	 YECHwCWLi6hK/Ott+CJfw1ZkvesOXIcke0fuDU0WjEAX03KpxtFDtG3B1Z/Z/YCd29
	 hd5q9pqq0b2JwdITMfoluQT28ONjey2+V1KKavZ1+AzV+FoWWH8QvqlTwQM5oc60/q
	 nQV6kE+xee2ig==
Message-ID: <bcfc588e-71de-4715-bcdb-754afaba3b50@kernel.org>
Date: Mon, 30 Jun 2025 14:09:18 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Daniel Gomez <da.gomez@kernel.org>
Subject: Re: [PATCH v2 1/2] module: Fix memory deallocation on error path in
 move_module()
To: Petr Pavlu <petr.pavlu@suse.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250618122730.51324-1-petr.pavlu@suse.com>
 <20250618122730.51324-2-petr.pavlu@suse.com>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <20250618122730.51324-2-petr.pavlu@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/06/2025 14.26, Petr Pavlu wrote:
> The function move_module() uses the variable t to track how many memory
> types it has allocated and consequently how many should be freed if an
> error occurs.
> 
> The variable is initially set to 0 and is updated when a call to
> module_memory_alloc() fails. However, move_module() can fail for other
> reasons as well, in which case t remains set to 0 and no memory is freed.
> 
> Fix the problem by initializing t to MOD_MEM_NUM_TYPES. Additionally, make
> the deallocation loop more robust by not relying on the mod_mem_type_t enum
> having a signed integer as its underlying type.

This is a follow up based on v1 discussion [1] regarding a way to reproduce
the leak.

[1]
https://lore.kernel.org/linux-modules/ae967353-71fa-4438-a84b-8f7e2815f485@kernel.org/

I tried using eBPF and moderr [2][3] to find a way to reproduce this. I run into
some issues but I applied some workarounds. If this is useful we can check at
how to solve this properly.

[2] moderr RFC:
https://lore.kernel.org/linux-modules/20250122-modules-error-injection-v1-0-910590a04fd5@samsung.com/

[3] updated moderr branch:
https://git.kernel.org/pub/scm/linux/kernel/git/da.gomez/linux.git/?h=b4%2Fmodules-error-injection

The logs below show an A/B test memory consumption comparison when a module
is loaded and leaked (A) because of the issue described in the commit log
vs when is correctly loaded/unloaded (B). Besides observing a huge leak,
kernel logs (dmesg) show the message "execmem: unable to allocate memory".
Note that we can't use kmemleak as we skip it with kmemleak_not_leak() in
module_memory_alloc(), except for is_rox memory.

Memory lost:
A test: 1220444 kB
B test: 892 kB

Thoughts?


Workflow to reproduce the issue (before applying this patchset):

1. Run moderr to return error in codetag_needs_module_section()

sudo moderr \
  -modname=brd
  --modfunc=module_codetag_needs_module_section \
  --error=1

Note: We can also force codetag_alloc_module_section() with:

sudo moderr \
--modname=brd \
--modfunc=module_codetag_alloc_module_section \
--error=-22
 
2. Run a loop to probe a module with:

while true; do modprobe brd; done

3. Monitor memory before/after and check delta:

Note: this output it's a wrapper around the above loop.

[*] Dropping caches...
[*] Wait...
[*] Starting memory: 6758564 kB
[*] Loop 200s...
[*] Wait...
[*] Dropping caches...
[*] Wait...
[*] Ending memory: 5538120 kB
[*] Memory lost: 1220444 kB
--- meminfo_before.txt  2025-06-30 10:29:49.880661145 +0000
+++ meminfo_after.txt   2025-06-30 10:33:20.091501671 +0000
@@ -1,38 +1,38 @@
 MemTotal:        8133036 kB
-MemFree:         6858820 kB
-MemAvailable:    6758652 kB
-Buffers:            2576 kB
-Cached:            73164 kB
+MemFree:         5620596 kB
+MemAvailable:    5538204 kB
+Buffers:            2552 kB
+Cached:           107256 kB
 SwapCached:            0 kB
-Active:            25448 kB
-Inactive:          95272 kB
-Active(anon):        176 kB
-Inactive(anon):    45684 kB
-Active(file):      25272 kB
-Inactive(file):    49588 kB
+Active:            67688 kB
+Inactive:          95284 kB
+Active(anon):        184 kB
+Inactive(anon):    54028 kB
+Active(file):      67504 kB
+Inactive(file):    41256 kB
 Unevictable:           0 kB
 Mlocked:               0 kB
 SwapTotal:             0 kB
 SwapFree:              0 kB
-Dirty:               468 kB
+Dirty:              2804 kB
 Writeback:             0 kB
-AnonPages:         45192 kB
-Mapped:            72028 kB
-Shmem:               916 kB
-KReclaimable:       5816 kB
-Slab:              42336 kB
-SReclaimable:       5816 kB
-SUnreclaim:        36520 kB
-KernelStack:        1984 kB
-PageTables:         2652 kB
+AnonPages:         53556 kB
+Mapped:           105784 kB
+Shmem:               936 kB
+KReclaimable:       7468 kB
+Slab:             176080 kB
+SReclaimable:       7468 kB
+SUnreclaim:       168612 kB
+KernelStack:        2016 kB
+PageTables:         5472 kB
 SecPageTables:         0 kB
 NFS_Unstable:          0 kB
 Bounce:                0 kB
 WritebackTmp:          0 kB
 CommitLimit:     3542228 kB
-Committed_AS:      89960 kB
+Committed_AS:      92956 kB
 VmallocTotal:   34359738367 kB
-VmallocUsed:        5112 kB
+VmallocUsed:     1041252 kB
 VmallocChunk:          0 kB
 Percpu:             1712 kB
 AnonHugePages:      4096 kB
@@ -49,6 +49,6 @@
 HugePages_Surp:        0
 Hugepagesize:       2048 kB
 Hugetlb:         1048576 kB
-DirectMap4k:       30548 kB
-DirectMap2M:     3115008 kB
-DirectMap1G:     7340032 kB
+DirectMap4k:      730964 kB
+DirectMap2M:     3463168 kB
+DirectMap1G:     6291456 kB

4. Check kernel logs

[   30.099667] tee (618): drop_caches: 3
[  221.695667] execmem: unable to allocate memory
{...}
[  226.701772] execmem_vmalloc: 1110 callbacks suppressed
{...}
[  231.705976] execmem_vmalloc: 1099 callbacks suppressed
{...}
[  231.742226] execmem: unable to allocate memory
[  231.747107] execmem: unable to allocate memory
[  240.109107] tee (92935): drop_caches: 3


Now, I repeated the test without error injection:

Loop:
while true; do modprobe brd && rmmod brd; done


[*] Dropping caches...
[*] Wait...
[*] Starting memory: 6747960 kB
Loop 100s...
[*] Wait...
[*] Dropping caches...
[*] Wait...
[*] Ending memory: 6747068 kB
[*] Memory lost: 892 kB
--- meminfo_before.txt  2025-06-30 11:21:44.922597662 +0000
+++ meminfo_after.txt   2025-06-30 11:23:35.023419139 +0000
@@ -1,38 +1,38 @@
 MemTotal:        8133036 kB
-MemFree:         6853796 kB
-MemAvailable:    6747960 kB
-Buffers:            2920 kB
-Cached:            61976 kB
+MemFree:         6852956 kB
+MemAvailable:    6747244 kB
+Buffers:            2540 kB
+Cached:            62124 kB
 SwapCached:            0 kB
-Active:            25968 kB
-Inactive:          83616 kB
-Active(anon):        176 kB
-Inactive(anon):    45744 kB
-Active(file):      25792 kB
-Inactive(file):    37872 kB
+Active:            26744 kB
+Inactive:          83120 kB
+Active(anon):        172 kB
+Inactive(anon):    46048 kB
+Active(file):      26572 kB
+Inactive(file):    37072 kB
 Unevictable:           0 kB
 Mlocked:               0 kB
 SwapTotal:             0 kB
 SwapFree:              0 kB
-Dirty:               996 kB
+Dirty:               452 kB
 Writeback:             0 kB
-AnonPages:         45116 kB
-Mapped:            54632 kB
-Shmem:               928 kB
-KReclaimable:       5680 kB
-Slab:              42392 kB
-SReclaimable:       5680 kB
-SUnreclaim:        36712 kB
-KernelStack:        1888 kB
-PageTables:         2468 kB
+AnonPages:         45372 kB
+Mapped:            59120 kB
+Shmem:               992 kB
+KReclaimable:       5940 kB
+Slab:              43056 kB
+SReclaimable:       5940 kB
+SUnreclaim:        37116 kB
+KernelStack:        1904 kB
+PageTables:         2460 kB
 SecPageTables:         0 kB
 NFS_Unstable:          0 kB
 Bounce:                0 kB
 WritebackTmp:          0 kB
 CommitLimit:     3542228 kB
-Committed_AS:      81484 kB
+Committed_AS:      81680 kB
 VmallocTotal:   34359738367 kB
-VmallocUsed:        5056 kB
+VmallocUsed:        7112 kB
 VmallocChunk:          0 kB
 Percpu:             1632 kB
 AnonHugePages:      2048 kB
@@ -49,6 +49,6 @@
 HugePages_Surp:        0
 Hugepagesize:       2048 kB
 Hugetlb:         1048576 kB
-DirectMap4k:       28500 kB
-DirectMap2M:     3117056 kB
-DirectMap1G:     7340032 kB
+DirectMap4k:      274260 kB
+DirectMap2M:     3919872 kB
+DirectMap1G:     6291456 kB
