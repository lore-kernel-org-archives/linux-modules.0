Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD513DB62F
	for <linux-modules@vger.kernel.org>; Tue, 31 Mar 2026 16:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774974207; cv=none; b=F62LJ7SCOQNWob2bU+GHuaawWSY18izmG2R8nYtormtoh543HOhPRgY13kUp/fHMmlRcdWois6/ku0OckyrC/EnEWJlm7FEkrDBnClQao1f7Cyp0PIfbZRAH2jQo7V3DKL8OBBizaB3O/Cmc74uCb+3BQmt3Z+pOxvR0AHQoyp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774974207; c=relaxed/simple;
	bh=E9q4kly1zyjlK/nXHV+iHGk+ZJrgY6vQu+gb1CC1Krs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nIlU/WudMKQOocHoZ8q2yKb0KqmeasHs1bKvMwXz80wTxdyVVRh5ah/Do7jT+w6sHocq1b/2HQbMc2U6k0kwZMrcJgvbu4c44OASHnvMJL38PppD/bQT7PeXnUXyguqJjNkuSRgeOHKrvHsdGPn76NjpEh8fnX+FZMgS73eipeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cnj2oWuj; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cnj2oWuj"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4887fd35e60so4454665e9.2
        for <linux-modules@vger.kernel.org>; Tue, 31 Mar 2026 09:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774974204; x=1775579004; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m8VbtpEHRuJbj4APKjXIpLAw6vG+/+ZV8XZtpmo84AQ=;
        b=cnj2oWujeG+Rd+Hh3BuIEI52IxN+ltrvQbSaXlh63V58EhVnIqrvP4UN98ZQoSaal2
         FkambSz0nhw5pw6SnVVBP8D9sYn9SLwRgUrJThe+5c+gPaW/lKxmq5gsvK1qegFo4/sl
         x8eP6i/SH3sjN4bpzSxZVwoZPPKWrslFwafej79CTARoc5/UUHkuiccWoGLtLdzqvN/O
         s3/+he6+2fdCWHgGZALQ9AlNuTqpagwl+UN1T63uCLNInXvzCLLZSq/Hjt5eA0V9smkq
         Br3eo1gM8CVYRCgwCDsfAQJn8YdJkx29/h7N4tGJnYAx7zguz5RFjUORmwg+XSMMICoC
         Isug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774974204; x=1775579004;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m8VbtpEHRuJbj4APKjXIpLAw6vG+/+ZV8XZtpmo84AQ=;
        b=mMJ6aJhtL7XGx6xuqRVSHmQ0hLPdfm1SXo+pGxG/Y3/DLGIluyVZPXuNI55O1QXuCx
         mB29soQf1pUv9TjCutMFYirvovmr9PG+A/nbryjb5slCHNFEqfv8boCCmEoEeAlnFZTh
         vgfKGt9xIMTQeVjV8bivoilZGTX+NXTAETZ8wCW4zPPB+Gre2w6JkH7DWZBwpYnbhCEc
         Wu8LfO4/5113Zuz85wKcqauBxRCKqFmhvRM22w7zaA1e/HE+hLgR/MIpyD5xn5D0yfaM
         4SbDb2NtKZQEni/HnQ2FVs08lEysD2iarf6eBVNebhfsWyAxjm0T/4az+6ZIWoifU07x
         VNcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVj/X4EM2EeeJ8oeYBPfCkPdED8iS5toUmP8D3AmC05tEPQadUmOgIFEJjbg48cvlxV25CcdvdXwVCJok9M@vger.kernel.org
X-Gm-Message-State: AOJu0YyEWvM5jOB7mqgWuVYjm862Lh7c8h7F6Buqr88AkXhVQjd7YtKP
	8dRZeMf4LPRnOz1Wqt9RH1aJh++PKUyig26OerTEGKFLgchNTNk21tkW5OBnKwDw1ug=
X-Gm-Gg: ATEYQzx8wnzJuBrheSMQj7l/A1BnU41V5qjrYrqzXxMs2WfagJaPddoU8J2VZ/36uc9
	lOb1o+id2S20bcUQE8Gh4Gpt2M8Y6f0WuaNk8AkxersPXwJy9/bK4W+CWRDsMNIstpK4v/gjX3N
	f++m8eCPccyNtO+Qdtjn/hUuveg4gaT3uZ2KJo1ELllkzlkb6n0mlXmnqeEmC5rbmELpHdrtnoj
	O25WaLwy5IA4B6/9o9e/NRguqXlSxinobIsDXQ50b+rKIW6jJEPYC3j+YAp7DjzrSAK4uQlC+I3
	SCDLXTSH1xs3ugikWib75A1lZIQP4j51VFebv++0YEbTbhDI4k81UVczuTaYFF+7Ms0fi+bpOpe
	wRmOZqGszDF2ZCrRz3QK3l5Q6t4W0HoMhL2Za3T2SaLV61cX0US8JmWF4Cj9+M4hDOZ8xBpr0q8
	7iESkYF4sqIpA7lApkklRyJLNMcgKA8YwXvduLJ5lLuPRddCBvk+rUdbv++86bcsVhlslLfhmxq
	oew/3Nnmoem73ZRwTdnWNQ4RXAhkp6KuB+mJg81o0ySWxOhLBz6MZIQipR+Xf4yZGuQ0D/e4xfw
	y1oK
X-Received: by 2002:a05:600c:45d4:b0:488:79a3:f04c with SMTP id 5b1f17b1804b1-48879a3f26cmr64380275e9.27.1774974203573;
        Tue, 31 Mar 2026 09:23:23 -0700 (PDT)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100? (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887adc5690sm34644865e9.2.2026.03.31.09.23.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 09:23:23 -0700 (PDT)
Message-ID: <2fb64da1-caac-4cb0-80a8-a6b6a0f690be@suse.com>
Date: Tue, 31 Mar 2026 18:23:21 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] kallsyms: extend lineinfo to loadable modules
To: Sasha Levin <sashal@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Masahiro Yamada <masahiroy@kernel.org>, Luis Chamberlain
 <mcgrof@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>,
 Richard Weinberger <richard@nod.at>, Juergen Gross <jgross@suse.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 Jonathan Corbet <corbet@lwn.net>, Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nsc@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Greg KH <gregkh@linuxfoundation.org>, Petr Mladek <pmladek@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>, Kees Cook <kees@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Thorsten Leemhuis <linux@leemhuis.info>, Vlastimil Babka
 <vbabka@kernel.org>, Helge Deller <deller@gmx.de>,
 Randy Dunlap <rdunlap@infradead.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Vivian Wang <wangruikang@iscas.ac.cn>, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20260312030649.674699-1-sashal@kernel.org>
 <20260312030649.674699-3-sashal@kernel.org>
 <79244e56-b3ea-4986-b4a2-91a78b21bf07@suse.com> <abwnvdbu4kjx7esJ@laps>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <abwnvdbu4kjx7esJ@laps>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/19/26 5:43 PM, Sasha Levin wrote:
>>> --- /dev/null
>>> +++ b/include/linux/mod_lineinfo.h
>>> @@ -0,0 +1,68 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +/*
>>> + * mod_lineinfo.h - Binary format for per-module source line information
>>> + *
>>> + * This header defines the layout of the .mod_lineinfo section embedded
>>> + * in loadable kernel modules.  It is dual-use: included from both the
>>> + * kernel and the userspace gen_lineinfo tool.
>>> + *
>>> + * Section layout (all values in target-native endianness):
>>> + *
>>> + *   struct mod_lineinfo_header     (16 bytes)
>>> + *   u32 addrs[num_entries]         -- offsets from .text base, sorted
>>
>> Modules are relocatable objects. The typical way to express a reference
>> from one section to data in another section is to use relocations.
>> Choosing to use an implicit base and resolved offsets means that the
>> code has trouble correctly referencing the .text section and can't
>> express line information data for other sections, such as .exit.text.
> 
> I agree, which is why I scoped this just to .text :)
> 
> My thinking was that using ELF relocations would add significant complexity to
> both the build tool and the runtime lookup path, which must remain NMI-safe and
> allocation-free.

I agree that using ELF relocations would be somewhat more complex. I had
a look at adding a new u32/u64 "target" member to the
mod_lineinfo_header struct which would point to the .text section in the
resulting module via an absolute relocation. The idea was to keep the
current offset and compression schema and only have a relocation that
identifies the associated text section. I hoped to replace the objcopy
steps in scripts/gen-mod-lineinfo.sh with an additional partial link to
combine ${KO} with ${KO}.lineinfo.o.

However, the issue with this approach is that the relocation in
${KO}.lineinfo.o cannot cross-reference the .text symbol in ${KO}. It
could be worked around by defining a start .text symbol in
scripts/module.lds.S but this doesn't scale well if more sections need
to be covered in the future. A separate utility would likely be required
to join the two objects properly together.

For the runtime part, I don't immediately see any issues. Relocations
are resolved by the module loader when a module is loaded, so this would
have no effect on the functionality being NMI-safe or allocation-free.

>>> +
>>> +#endif /* _LINUX_MOD_LINEINFO_H */
>>> diff --git a/include/linux/module.h b/include/linux/module.h
>>> index 14f391b186c6d..d23e0cd9c7210 100644
>>> --- a/include/linux/module.h
>>> +++ b/include/linux/module.h
>>> @@ -508,6 +508,8 @@ struct module {
>>>      void *btf_data;
>>>      void *btf_base_data;
>>>  #endif
>>> +    void *lineinfo_data;        /* .mod_lineinfo section in MOD_RODATA */
>>> +    unsigned int lineinfo_data_size;
>>
>> The lineinfo-specific members should be enclosed within the `#ifdef
>> CONFIG_KALLSYMS_LINEINFO_MODULES`.
>>
>> This will require module_lookup_lineinfo() to be conditionally compiled
>> based on CONFIG_KALLSYMS_LINEINFO_MODULES, with a dummy version provided
>> otherwise. Alternatively, accessors to module::lineinfo_data and
>> module::lineinfo_data_size that handle CONFIG_KALLSYMS_LINEINFO_MODULES
>> could be introduced in include/linux/module.h. For example, see
>> module_buildid() or is_livepatch_module.
> 
> The struct members were deliberately left without #ifdef guards following Helge
> Deller's suggestion in the v1 review[1]. I don't really mind either way, but
> I'd prefer to have a consensus before flipping it back and forth.

The alternative suggestion I mentioned proposes using accessors to
module::lineinfo_data and module::lineinfo_data_size that would handle
CONFIG_KALLSYMS_LINEINFO_MODULES. This approach avoids having unused
data in the module struct when CONFIG_KALLSYMS_LINEINFO_MODULES=n, while
also allowing module_lookup_lineinfo() to use the
IS_ENABLED(CONFIG_KALLSYMS_LINEINFO_MODULES) pattern and be always
syntax-checked. Only the accessors won't be always syntax-checked but
their code should be trivial.

The file include/linux/module.h could contain something like this:

struct {
	[...]
#ifdef CONFIG_KALLSYMS_LINEINFO_MODULES
	void *lineinfo_data;		/* .mod_lineinfo section in MOD_RODATA */
	unsigned int lineinfo_data_size;
#endif
	[...]
}

[...]

static inline void *module_lineinfo_data(struct module *mod, unsigned int *size)
{
#ifdef CONFIG_KALLSYMS_LINEINFO_MODULES
	*size = mod->lineinfo_data_size;
	return mod->lineinfo_data;
#else
	*size = 0;
	return NULL;
#endif
}

>>> @@ -59,6 +62,9 @@ if_changed_except = $(if $(call newer_prereqs_except,$(2))$(cmd-check),      \
>>>      +$(call if_changed_except,ld_ko_o,$(objtree)/vmlinux)
>>>  ifdef CONFIG_DEBUG_INFO_BTF_MODULES
>>>      +$(if $(newer-prereqs),$(call cmd,btf_ko))
>>> +endif
>>> +ifdef CONFIG_KALLSYMS_LINEINFO_MODULES
>>> +    +$(if $(newer-prereqs),$(call cmd,lineinfo_ko))
>>
>> Should this be 'if_changed_except.. vmlinux'?
> 
> Lineinfo generation doesn't depend on vmlinux - it reads DWARF directly from
> the .ko file itself. Unlike BTF (which uses vmlinux as a base for
> deduplication), there's no vmlinux prerequisite to exclude.

The Makefile rule is:

%.ko: %.o %.mod.o .module-common.o $(objtree)/scripts/module.lds $(and $(CONFIG_DEBUG_INFO_BTF_MODULES),$(KBUILD_BUILTIN),$(objtree)/vmlinux) FORCE

If $(and $(CONFIG_DEBUG_INFO_BTF_MODULES),$(KBUILD_BUILTIN)) then
$(objtree)/vmlinux is added as a prerequisite for the target. Since the
new lineinfo_ko call uses $(newer-prereqs), it is invoked even when
vmlinux changes.

However, the mentioned change to 'if_changed_except.. vmlinux' won't
quite work either because if_changed_except appears to have a similar
limitation as if_changed. It can be used only once per target due to
storing the executed command in a corresponding .cmd file.

Additionally, even the already present if_changed_except call for
ld_ko_o doesn't seem to work as intended because it excludes "./vmlinux"
but the same rule prerequisite is canonicalized to only "vmlinux". This
means modules are always linked even when only vmlinux changes. I'll
send a fix for this separately.

> 
>>> @@ -194,9 +200,45 @@ static const char *make_relative(const char *path, const char *comp_dir)
>>>          return p ? p + 1 : path;
>>>      }
>>>
>>> -    /* Fall back to basename */
>>> -    p = strrchr(path, '/');
>>> -    return p ? p + 1 : path;
>>> +    /*
>>> +     * Relative path — check for duplicated-path quirk from libdw
>>> +     * on ET_REL files (e.g., "a/b.c/a/b.c" → "a/b.c").
>>> +     */
>>
>> When does this quirk occur? Is it a bug in libdw?
> 
> This occurs with elfutils libdw when processing ET_REL .ko files.  libdw
> constructs source paths by concatenating DW_AT_comp_dir with DW_AT_name from
> the compilation unit. For modules where both are relative paths with the same
> prefix, this can produce doubled results like "net/foo/bar.c/net/foo/bar.c". It
> appears to be a libdw quirk with ET_REL DWARF handling.

Thanks for the explanation.

-- Petr
