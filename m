Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3466C43DA49
	for <linux-modules@vger.kernel.org>; Tue, 15 Sep 2026 18:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789496627; cv=pass; b=I1+VRpAIRQmozU49qEkGWGkvhkSlkcNWmSgovPqgi2+uWxmMS+G6eL4Ms+8hSJVcQ2RuHQz9UW9Fz/jTTo0N4Y47uGjaE4cagF8o1qLZNS4HQfGhTBQruEvr+6QAxml2heiAbtz7lG7NlVPYImC4sxKNsU0P/9MqlRSdN/xFyRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789496627; c=relaxed/simple;
	bh=0Gey+DPzi1RiCBNuof2TQ98crau129coDD4czU1PCo8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qq00Pk1OMrLtpEnaR0NPbEQNx9oiJLiOh1sSpKnYcLK8jKnOO1zTuf9jXLvCFS0HQVhXI0NOISmSfjHZqqnG9Otz/AQSYDFCqRy+8CjIoW4Fvx6uKXpYxT/cUQlHptAXtVzUUc4drYtlUDJTLOQ9vdDsqjqTU3NzqaKWa35bVwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DcHZ38Hm; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DcHZ38Hm"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-530411c7ee1so38191cf.0
        for <linux-modules@vger.kernel.org>; Tue, 15 Sep 2026 11:23:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789496624; cv=none;
        d=google.com; s=arc-20260327;
        b=UN8KK7X6FD/V82PpAkQoBitZmm5RnxCJAY1lbmVTmIf9HULLysmoPpBzo94psuEa17
         hOD5daXXU+VeZe41HX7b+xH4o6deuvNfL0pExbJdQyW3uxfVJXqHae5rhyM0D19prel9
         9ylwDZqNkhTsJMwLn2FLhHIQcspyNr0w7HWFZu4cdw5Svv9bKSrQMHqtsAcebSU/u+46
         rMdpIQBd/O+OghO5wiGFnMeA5JQx53yvFDD3nKIYqU4c/Fmf7ckts9fNQMugnHbQYO+r
         Ah2EjCB7gsnA38SR7h1FBtv++Doj4lsHl5Cra1qVn8ou0Ob62Qx05RcKeBZkQer0wWk8
         k4Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2rssnQIdYryZ5dCEXCBYmfezXeqT2y3ieJZn8XMJig4=;
        fh=buQQoDu1m1ouREWFqNyWiz2n1Ag/G6aX3I2mm/hpCZA=;
        b=aZX+ozKUqWPpTf1+f2qwVtleT5VDxFzHys+HvMWd0Ti/D7MDM+/ftcAXrqxVvvj9Gj
         gYN3kTolP1rUYfYyDeXMHJ1+PzYqTI/4FSdvW77NwU14OaHyAPWgdPZK1k28Mwk6ofKp
         ScD7QqbM2zKtsADBq6sTJ+Zwk/FT4Cxjc+SLndu/ddBvZWEtdDcuYlWZHVAcxlr7YBtt
         VJiqQrtzZtW3hsqkm65E5CqlOwwMxFpKiXRrIdCQhJTl8tBu36cTAeBNrmPYjXp4SPJf
         Fv3VBTw5pr3NxHj0HgKRY/OknGp6TsuVDqBRNMiTsyVwq0jf775PBi1VWo+Ix66lMZFA
         nUMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789496624; x=1790101424; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2rssnQIdYryZ5dCEXCBYmfezXeqT2y3ieJZn8XMJig4=;
        b=DcHZ38HmYppMVZsxwe3dovwUouEAKkTjMt7soYwxzFBOoP2tcudYK6SuXHBbVPCvzY
         lGhWzsobF3jIxer6IPVYZVkrPSuxQICoIxg7VdJ6J8cI2efnMXsqQk+1Dni03zDmnNdm
         IFfGZwVZ+kxQkxX2JJKLZHow1gI5znjVfuz5FYwuz1Gi6O1mMmDcLjyRqWLeuBn3y6ot
         pjgamWwHaF8dnzTGq2umaRbEOzW46HJpwdRkHMFEkMkGRxSwdA5l2BMndh/mFyeHP0XR
         +SKKm5B2szoUCdQN1/biwPuUB2/qZ3O/9RLmZfRpgF2UGcCmEpZyNhu9zh8kWQXAcC7n
         0iyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789496624; x=1790101424;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2rssnQIdYryZ5dCEXCBYmfezXeqT2y3ieJZn8XMJig4=;
        b=uyAwFMmePyEjB9rC8T7wofbL7urSamijIVD0J7MxZi7eKzTArV2kNU5bnAR6BIa3P0
         EXTL8LNlklCiDuNgyMqWUSqUPIY+Jyblx8yL6VNQAmnFFzqtKkYqzhjV754u0eVmz0IF
         gAEEYErz+Hux51WYPlM6cw0EKxFwycxLkzAxg+vz9sry4rFWE+BzpHzy+rKQKQCsi62n
         XpJVL5KXkJkYW6WPgBzLYO+VkKd3sok1nKAmUu8MgeSHsnpIDtDSZ+QKNcQTyvBpx/vd
         zHzA8UDIQyeXXoJoWbvPcNjdh/vfDBHLshT3RVFxXV4L7u9aa497IPvNBW4ksrJDx94r
         Sljw==
X-Forwarded-Encrypted: i=1; AKwUvBwY3lw/vU2YJvR/ni8Tfg5Zds3jt1TwOOp+Ktu/wCk1R7FgAxpbXjMjK+XWydX6rEow3nOLLtSImZlARbIC@vger.kernel.org
X-Gm-Message-State: AFuF++nNXc6NiksUk/7XvkUA88QFQUDLhT/0UtedWd7oGhcE1+wKUy3n
	8CJzqGK9WND+tCUu3ZMjzYIA9/9POy4WMOcBFyHAIK2spGJbSLS8kzPMiYShE73Ql0xsfNPfMZo
	LQKFZX3qTZecc1lDB4hbpAJoGC7Oita055Pnc1bWV
X-Gm-Gg: AYBFou17OeYSsRVZt3Cp0L5emhsnZN/Xg7z+aw7WlHNUXwuK9dEYMSex7CFIdC1GVPw
	GhI78jwiuFtPMZr1Ks5cWUaYdtGhHClTAbIUow0+LBfza45kWek/45/97HAtJ8d3S2BxGVuGPn9
	p96nV8buETiVVQA6soeNkcCpxMO7MmcLtOxR2Op1eFl4bvoWigNCP/tQAG1sPc5l/DYbAueMpfK
	YbWaAZmFaTYvrM0XywYerEjzlFXDGNr3H8F54BYw/YRyMuSxVf8DwmIGg3pIIv/JJHPylSxOxAl
	0cLWMDhbGwy6F21T2ZxUVLaikkHaFMvI8cy2a+Aodd59zeff347ngmbeiTos9rnkYFlBSV6Ab8p
	4vjzvQlmZ9Q==
X-Received: by 2002:a05:622a:1e0a:b0:50f:af60:3496 with SMTP id
 d75a77b69052e-53259a908fbmr904071cf.1.1789496623375; Tue, 15 Sep 2026
 11:23:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915070001.113559-1-hao.ge@linux.dev>
In-Reply-To: <20260915070001.113559-1-hao.ge@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 15 Sep 2026 11:23:32 -0700
X-Gm-Features: AcwNN1VCvcBTjNHTTeUHVRptD9lm4JQ38a2UaA1WJQc0tRf_bIU32vhrmnbsOaQ
Message-ID: <CAJuCfpE3z69Dqn_HoBz_XX+_hQMXeuqA04o4t=xQLaWFHmwqPQ@mail.gmail.com>
Subject: Re: [PATCH v10 0/6] alloc_tag and module codetag section fixes
To: Hao Ge <hao.ge@linux.dev>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-modules@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 11:59=E2=80=AFPM Hao Ge <hao.ge@linux.dev> wrote:
>
> With profiling toggled off, the overflow check in
> reserve_module_tags() did not run, a module could load with more
> tags than the page flags can address, and re-enabling profiling
> then silently corrupted /proc/allocinfo. On overflow the fix shuts
> profiling down, releases the reservation and returns -EAGAIN, and
> the codetag section lands as regular module data in the same load,
> so the module loads without profiling.
>
> Review of the earlier series by Sashiko turned up two more problems.
>
> One is a race. layout_sections() and move_module() both asked
> codetag_needs_module_section() where a codetag section goes, and
> mem_profiling_support can change between the two calls, for instance
> when another module load overflows the tag index and shuts profiling
> down. move_module() then copied the codetag section to offset 0 of
> its regular destination and clobbered the first section placed in
> that region.
>
> v7 reworks where codetag sections are allocated, on a prototype by
> Petr Pavlu [1]. The allocation runs before layout_sections() and the
> placement is decided in one step, so nothing re-asks the question
> and the race is gone. The retry is gone too, on -EAGAIN the section
> is laid out as regular module data right in the same load.
>
> [1] https://lore.kernel.org/all/499bb60c-c6e3-43a3-bd92-95a0567ece5e@suse=
.com/
>
> Following review feedback from Petr and Suren the series is now
> split into six patches. The two alloc_tag fixes from [2] are folded
> in as patches 5 and 6 and replace the versions currently in the mm
> tree. Sashiko keeps flagging the percpu counter leak [3], patch 5
> fixes it, and now the whole set goes through review again.
>
> [2] https://lore.kernel.org/all/20260817062726.106511-1-hao.ge@linux.dev/
> [3] https://lore.kernel.org/all/20260908094736.2B1A61F00A3A@smtp.kernel.o=
rg/
>
> Patch 1 moves release_module_tags() above reserve_module_tags(),
> since the failure paths now have to call it.
>
> Patch 2 cleans up the populate failure path: the reservation is
> released, module_tags.size rolled back and the PTEs a failed
> vmap_pages_range() left behind unmapped, so a later populate of the
> same range is safe. It carries both Fixes tags so it backports
> wherever patch 4 goes, which uses its prev_size.
>
> Patch 3 introduces SH_ENTSIZE_STANDALONE to mark sections with a
> separate allocation. The percpu section was previously excluded
> from the layout by clearing its SHF_ALLOC, which per the ELF spec
> says the section occupies memory during execution, and percpu does,
> only outside the regular module layout. The mark lives in sh_entsize
> now, find_sec(".data..percpu") gives stable results again and
> apply_relocations() goes back to testing only SHF_ALLOC. The
> section would show up under /sys/module/*/sections/, but it has one
> instance per CPU and no single address, and the entry never
> existed, so add_sect_attrs() and add_notes_attrs() skip it.
>
> Patch 4 moves the codetag allocation out of move_module() in front
> of layout_sections(), so the placement is decided in one step and
> the race is gone. On overflow profiling is shut down, the
> reservation released, module_tags.size rolled back and -EAGAIN
> returned, the section is laid out as regular module data and the
> module loads without profiling instead of failing. Any other error
> fails the load. The release and the fallback belong together,
> without the release rmmod hits the stale entry and panics.
>
> Patch 5 skips the percpu counter allocation when profiling is off.
> After the shutdown modules load their codetag section as regular
> data, load_module() still allocated counters for every tag and
> release_module_tags() cannot find them on unload, so they leaked
> (Suggested by Suren).
>
> Patch 6 defers the /proc/allocinfo removal to a workqueue.
> shutdown_mem_profiling() runs under mod_lock, and the synchronous
> remove_proc_entry() deadlocks with a reader taking mod_lock for
> read in allocinfo_start(). The file is also created at the end of
> alloc_tag_init(), a leftover file after a failed init would panic
> its readers (Found by Sashiko).
>
> Tested on an x86_64 virtual machine:
>
> Booted without sysctl.vm.mem_profiling=3D1,compressed:
> # cat /proc/allocinfo is fine
>
> Booted with sysctl.vm.mem_profiling=3D1,compressed:
> # cat /proc/allocinfo is fine
> # insmod overflow_tag.ko
> # dmesg
>   With module overflow_tag there are too many tags to fit in 13 page
>   flag bits. Memory allocation profiling is disabled!

Do you have your overflow_tag module posted anywhere in public (github perh=
aps?)

> # rmmod overflow_tag
> The module loads without profiling and unloads cleanly.
>
> Also ran continuous LTP stress for a few days, nothing abnormal
> so far.
>
> Changes in v10:
> - fold in the two alloc_tag fixes from [2] as patches 5 and 6, they
>   replace the versions in the mm tree and fix the percpu leak
>   Sashiko keeps flagging [3]
> - create /proc/allocinfo at the end of alloc_tag_init(), a
>   leftover file after a failed init would panic its readers
>   (Found by Sashiko)
> - count note sections with sect_visible() in add_notes_attrs() too,
>   the count has to match the fill loop
>
> Changes in v9:
> - do not export .data..percpu under /sys/module/*/sections/ (Petr
>   Pavlu).
> - move the populate failure cleanup in front of the rework, v8 patch
>   4 is patch 2 now. It declares prev_size itself, which the overflow
>   path of the rework also uses, so it carries both Fixes tags and the
>   two patches backport together
>
> Changes in v8:
> - roll back module_tags.size when the reservation is released, so a
>   concurrent load which already passed needs_section_mem() does not
>   skip populate for the freed gap (Sashiko)
> - unmap the PTEs a failed vmap_pages_range() installed, a retry to
>   populate the same range would BUG on them
> - zero the separately allocated codetag memory for an SHT_NOBITS
>   section, the tag area pages are not zeroed on allocation (Sashiko)
> - .data..percpu is exported under /sys/module/*/sections/ with the
>   boot CPU instance of the per-cpu area, and the interface is
>   documented in the ABI docs (Petr Pavlu)
> - keep a comment in apply_relocations() on how .data..percpu is
>   relocated (Petr Pavlu)
> - replace the "Based-on-a-patch-by:" tag with an in-body
>   attribution and a numbered Link: (Andrew Morton)
>
> Changes in v7:
> - split the rework following review feedback (Petr Pavlu, Suren
>   Baghdasaryan)
> - new patch 2 marks separately allocated sections with
>   SH_ENTSIZE_STANDALONE instead of clearing SHF_ALLOC
>   (suggested by Petr Pavlu)
> - split the populate failure release into its own patch (suggested
>   by Suren Baghdasaryan)
>
> Changes in v6:
> - rework on Petr's prototype and allocate codetag sections before
>   layout_sections(), the retry and its state resets are gone
> - fix the layout_sections()/move_module() race (Found by Sashiko)
> - release the reservation on populate failure as well (Found by
>   Sashiko)
> - only -EAGAIN keeps the fallback, other errors fail the load
>
> Changes in v5:
> - add Fixes: and Cc: stable to patch 1/2 as well, since 2/2 does not
>   compile without it (Andrew Morton)
> - restore frob-adjusted mem[type].size on retry instead of zeroing,
>   as s390 and parisc add GOT/PLT space there in
>   module_frob_arch_sections() (Reported by Sashiko)
> - drop the load_module() mem_profiling_support check; the percpu
>   counter leak is pre-existing and orthogonal to this fix
>
> Changes in v4:
> - add a new patch (1/2) to move release_module_tags() above
>   reserve_module_tags(); the overflow fix is 2/2
> - release the reservation on the -EAGAIN path
> - return -EAGAIN instead of -ENOMEM so the module can still load
>   without profiling (Suren)
> - reset sh_addr, mem[type].size and sym/str SHF_ALLOC before retry
> - skip percpu counters in load_module() when profiling is off
>
> Changes in v3:
> - use pr_warn_once() instead of pr_warn()
> - return -ENOMEM instead of -ENOSPC (Suren)
> - expand the commit message to describe the /proc/allocinfo impact
>   (Andrew)
>
> Changes in v2:
> - return an error after shutdown_mem_profiling() to skip
>   vm_module_tags_populate()
>
> v1: https://lore.kernel.org/all/20260804064408.105033-1-hao.ge@linux.dev/
> v2: https://lore.kernel.org/all/20260804122038.190270-1-hao.ge@linux.dev/
> v3: https://lore.kernel.org/all/20260805090633.141001-1-hao.ge@linux.dev/
> v4: https://lore.kernel.org/all/20260810093955.153015-1-hao.ge@linux.dev/
> v5: https://lore.kernel.org/all/20260812054105.102637-1-hao.ge@linux.dev/
> v6: https://lore.kernel.org/all/20260831072104.120197-1-hao.ge@linux.dev/
> v7: https://lore.kernel.org/all/20260902081802.146145-1-hao.ge@linux.dev/
> v8: https://lore.kernel.org/all/20260907062414.106873-1-hao.ge@linux.dev/
> v9: https://lore.kernel.org/all/20260908092412.115953-1-hao.ge@linux.dev/
>
> Hao Ge (6):
>   alloc_tag: move release_module_tags() above reserve_module_tags()
>   alloc_tag: clean up the populate failure path
>   module: introduce SH_ENTSIZE_STANDALONE for separately allocated
>     sections
>   module: allocate codetag sections before the regular module layout
>   alloc_tag: skip percpu counter allocation when profiling is disabled
>   alloc_tag: Defer /proc/allocinfo removal to a workqueue
>
>  include/linux/module.h   |   2 +
>  kernel/module/internal.h |   8 +++
>  kernel/module/kallsyms.c |  13 +---
>  kernel/module/main.c     | 133 +++++++++++++++++++-----------------
>  kernel/module/sysfs.c    |  17 +++--
>  lib/codetag.c            |  10 ++-
>  mm/alloc_tag.c           | 141 +++++++++++++++++++++++----------------
>  7 files changed, 188 insertions(+), 136 deletions(-)
>
> --
> 2.25.1
>
