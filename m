Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDEC37B032
	for <linux-modules@vger.kernel.org>; Tue,  3 Mar 2026 21:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772573598; cv=none; b=miDYdZi87sWinVHiUC3kxpuJl2HvRthpzPWv78ihnhwDFCTYiTxgrcKnpVF7VTaQFgmWU4RuvSH1szLYEvaDrE0W9ZaDr0BGgo/GkI687SCwCLB5LyEw6v9g1cxhgS6THzgQg78KZPIHl0HXLZBY/pWfYJZ9/G0s2xU/BS76kLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772573598; c=relaxed/simple;
	bh=GKC/6aY/fX4AuHN5nvpVSyIlMI8YejQxjzNrIxlG8cI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TdcpbGh39Y28W25X131e9joPKmyb5r7IIgx+Xg2Ctg8sA6oSl0/SoGoEekjBvTfc6rr3hRdf5Xk3jJLmBSqB4n2s3BsunHsTpPJMzWUgXvrTdEcphHKpjr79ohZd188Kt8aTZz1mydRyrBe9so7KfNqGuq3rviiWwJJARWbIyI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-4648448e387so4393547b6e.1
        for <linux-modules@vger.kernel.org>; Tue, 03 Mar 2026 13:33:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772573596; x=1773178396;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hmPwQkA8aJZjLJygLiKXdhC/x1FwVUYVZ/mvrrcqizQ=;
        b=eQyB8heMJb7gMX0WRFV7OvV005/lBUpPptUlhcuRl4oYhKa2gbGxnvhzVdaB8kXIY0
         IBF1wct9Ov+RaRcX+KqTEIgwb8N0SfuzIFnueaQqKSRITK42nTuNEgC2xbCf8u9MItre
         kE8tNBE7zDQi+pTMhu3hnooXYMrLe/U+9Ra7WU8v+eH5BbIbhpgCSM1z1Ck13B9sHXSW
         85zPKXW6eqTaBPrpc36p0fp+v9kUyGOqqzupGbZ47JzfBvdKOS0fzzeghkLyMmg2k0Lu
         oJpx6aLT34S2+zr/6Fo4SYJbVT0mEZlcXkwmuIe4Zjrru8A9B15ELxlHmUUMBk/laRs5
         KLWg==
X-Forwarded-Encrypted: i=1; AJvYcCVf6FkXVUAresFxYBz8CYAYvrO1BjPAPFNfcL46pY9mQkUtGwa+UQZozbPrl1eTIGIQJuKdAsd9Ne0jlz6d@vger.kernel.org
X-Gm-Message-State: AOJu0YzSRna5Y+A0EzLs/wH4FeN6MvNaz6yliYXOqbC7vlVdrYWgJ6Z2
	CiURBbRvUYJIp9K18nvTUCiNAuOGCyikh5JdjePLxtj+6ecA/SceePM/pspo9vkH
X-Gm-Gg: ATEYQzzHs51k7Q6lm4c7uX1qRl2MNxJ/1ybvxEjlVpmdFgIBpqG5GS/LJaumAnt/PzD
	gzznjRcnCrzK43lZy2STDu4N1MltfT7052TgvqG/vvpp83n8928GxHYxRpqWH6UU+urfUFhv7wo
	h3Pd72/xAScgeBzSSslSo5rr6OlmIBIsfqrEJCUKypFvwro6nRDLtdSSDiiIEN39IQy/yBGx7lz
	t6V+QazRxrk8YCYdW9UUejF+jgGsHbQvlQAdNdJzlZbaxUgXjcUiVjr4bxBCPrjydrGY3FCeyUG
	bLqj/hxxSbFpzxEXvtY4Yr2CPjppQ/w7qSqQo1b8c86KQIVZeSMGVcgKiTSS8PkWM3vD7L9dCf8
	b3uPJgVrKJ6KpacLJZ6oRdbkje6vApASTWdWapj+uEV5rqKeY9xx1fCjL5vPMJnczZyHMr3Finx
	SXrRR3Q31pVnKcik7oWo3RkywOqZSsyJOLRGeJZhWhSjsgPt0+meM8/cMXnvHtuGto
X-Received: by 2002:a05:6808:67c1:b0:44d:a429:e816 with SMTP id 5614622812f47-464bebfd497mr9345945b6e.53.1772573596004;
        Tue, 03 Mar 2026 13:33:16 -0800 (PST)
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com. [209.85.167.169])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-464bb5e417fsm10089088b6e.16.2026.03.03.13.33.15
        for <linux-modules@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2026 13:33:15 -0800 (PST)
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-463960df4f9so4446843b6e.0
        for <linux-modules@vger.kernel.org>; Tue, 03 Mar 2026 13:33:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUZrDdovzHyUHxlEIjvtzj9gcuH8nPdRQ9m7bWGA+59V5dJuTSscZJrEzd0iwI5PMh+LMbU7MFyv/MiUq4G@vger.kernel.org
X-Received: by 2002:a05:6102:943:b0:5ed:f13:e58a with SMTP id
 ada2fe7eead31-5ff325ad1bbmr6476605137.37.1772573130116; Tue, 03 Mar 2026
 13:25:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303182103.3523438-1-sashal@kernel.org> <20260303182103.3523438-4-sashal@kernel.org>
In-Reply-To: <20260303182103.3523438-4-sashal@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 3 Mar 2026 22:25:19 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUv61E0wnQOaZ+M+pXrzZNYzsQLQV_05uTpz7YXyu25VQ@mail.gmail.com>
X-Gm-Features: AaiRm50MU22nmE-L93SR-97Qa2M72gOliUTByfCL_hDHorQGfLK5J9LZ0BvCKqM
Message-ID: <CAMuHMdUv61E0wnQOaZ+M+pXrzZNYzsQLQV_05uTpz7YXyu25VQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] kallsyms: delta-compress lineinfo tables for ~2.7x
 size reduction
To: Sasha Levin <sashal@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Richard Weinberger <richard@nod.at>, Juergen Gross <jgross@suse.com>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, Jonathan Corbet <corbet@lwn.net>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, 
	Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Kees Cook <kees@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thorsten Leemhuis <linux@leemhuis.info>, 
	Vlastimil Babka <vbabka@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Sasha,

On Tue, 3 Mar 2026 at 19:22, Sasha Levin <sashal@kernel.org> wrote:
> Replace the flat uncompressed parallel arrays (lineinfo_addrs[],
> lineinfo_file_ids[], lineinfo_lines[]) with a block-indexed,
> delta-encoded, ULEB128 varint compressed format.
>
> The sorted address array has small deltas between consecutive entries
> (typically 1-50 bytes), file IDs have high locality (delta often 0,
> same file), and line numbers change slowly.  Delta-encoding followed
> by ULEB128 varint compression shrinks most values from 4 bytes to 1.
>
> Entries are grouped into blocks of 64.  A small uncompressed block
> index (first addr + byte offset per block) enables O(log(N/64)) binary
> search, followed by sequential decode of at most 64 varints within the
> matching block.  All decode state lives on the stack -- zero
> allocations, still safe for NMI/panic context.
>
> Measured on a defconfig+debug x86_64 build (3,017,154 entries, 4,822
> source files, 47,144 blocks):
>
>   Before (flat arrays):
>     lineinfo_addrs[]    12,068,616 bytes (u32 x 3.0M)
>     lineinfo_file_ids[]  6,034,308 bytes (u16 x 3.0M)
>     lineinfo_lines[]    12,068,616 bytes (u32 x 3.0M)
>     Total:              30,171,540 bytes (28.8 MiB, 10.0 bytes/entry)
>
>   After (block-indexed delta + ULEB128):
>     lineinfo_block_addrs[]    188,576 bytes (184 KiB)
>     lineinfo_block_offsets[]  188,576 bytes (184 KiB)
>     lineinfo_data[]        10,926,128 bytes (10.4 MiB)
>     Total:                 11,303,280 bytes (10.8 MiB, 3.7 bytes/entry)
>
>   Savings: 18.0 MiB (2.7x reduction)
>
> Booted in QEMU and verified with SysRq-l that annotations still work:
>
>   default_idle+0x9/0x10 (arch/x86/kernel/process.c:767)
>   default_idle_call+0x6c/0xb0 (kernel/sched/idle.c:122)
>   do_idle+0x335/0x490 (kernel/sched/idle.c:191)
>   cpu_startup_entry+0x4e/0x60 (kernel/sched/idle.c:429)
>   rest_init+0x1aa/0x1b0 (init/main.c:760)
>
> Suggested-by: Juergen Gross <jgross@suse.com>
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Thanks for your patch!

> --- a/include/linux/mod_lineinfo.h
> +++ b/include/linux/mod_lineinfo.h

> +/*
> + * Read a ULEB128 varint from a byte stream.
> + * Returns the decoded value and advances *pos past the encoded bytes.
> + * If *pos would exceed 'end', returns 0 and sets *pos = end (safe for
> + * NMI/panic context -- no crash, just a missed annotation).
> + */
> +static inline u32 lineinfo_read_uleb128(const u8 *data, u32 *pos, u32 end)
> +{
> +       u32 result = 0;
> +       unsigned int shift = 0;
> +
> +       while (*pos < end) {
> +               u8 byte = data[*pos];
> +               (*pos)++;
> +               result |= (u32)(byte & 0x7f) << shift;
> +               if (!(byte & 0x80))
> +                       return result;
> +               shift += 7;
> +               if (shift >= 32) {
> +                       /* Malformed -- skip remaining continuation bytes */
> +                       while (*pos < end && (data[*pos] & 0x80))
> +                               (*pos)++;
> +                       if (*pos < end)
> +                               (*pos)++;
> +                       return result;
> +               }
> +       }
> +       return result;
> +}

FTR, arch/arc/kernel/unwind.c, arch/sh/kernel/dwarf.c, and
tools/perf/util/genelf_debug.calready have (different) LEB128 accessors,
so there is an opportunity for consolidation.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
