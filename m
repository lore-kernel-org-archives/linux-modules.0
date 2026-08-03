Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965CA246768
	for <linux-modules@vger.kernel.org>; Mon,  3 Aug 2026 16:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785773776; cv=none; b=OHHwp2To2hDehaiLRBCk5JqRFZP8dZ7QnQQ72elJqnVMXM2IkfL/XMgyZfI9qH42vx63t9EJBgiBRv1X1PbJVbxb5KsQb7NNVszIiOyfK0AWGdieZiKKYaP7WhnJtsLAymJGX6fako1uuWoTyKoBpCfdI7qsf+MUSr8tPPcEnhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785773776; c=relaxed/simple;
	bh=6F+BXZLkEjsy2awsUZvLvI/HwblpfNwSj8SCQWaGXZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wg1cBkoK9NVYiHJjspR4Is9BuzwCuyD1ixAgw1RobylWeNGR9XstI7IXOEC9oOxMpO71d8jjpUWPlzDM2+WPXGHK3qbpndOz5IzpzwWfHAJLB5MgA2YmjYhQ4/mjeonl7kFqxICI9AZ2ejatbn/X0qTKasnAqYaOA9IrrC4WtkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Id3Gl/5x; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Id3Gl/5x"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47f3b39f2a1so2752324f8f.2
        for <linux-modules@vger.kernel.org>; Mon, 03 Aug 2026 09:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1785773773; x=1786378573; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c5F4lepwsFsNLNdrWCSohbLrCx4necgAw6oTKmSF28A=;
        b=Id3Gl/5xttAaonAbG+yKrAeSvSr9ClwGid7GiiUmBRjWdV+eOMgj9VEXJpp6DaAWSM
         VWKEs5w6oL04nk7i1HTqeRapDg/VW6KDmS7eniUzPjecmU22T9tldewzi8KWogx1pG3l
         98amgpgcWAm1IBEKlxbE4Rza9YVzxHHq/HQ1I47AUELjjM0wN0LwfgRSsbH2J9/eA+f2
         HllNtNH6TZ/Kt00kTvvP+FQIKVmeBEM2TgxjKT3NMOKjp9JEXUgYZwIPcYopEdcHmO6a
         zWtDrcIC2lSZfNcuw+0DRVpucpWRdwhJxvCUoJJkA0ua69PpZ7vBY9dX+b0p23sD1IlW
         N9yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785773773; x=1786378573;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c5F4lepwsFsNLNdrWCSohbLrCx4necgAw6oTKmSF28A=;
        b=TlaPOHKg/SxOCQSmTxWSzR7UA9OCeoy3gFgg0UhrHHAJr8akxkn4KKHObb1aI7k4PW
         oyfqnC31jVin2Pq09dUlfK6IxfEWlK1Ng+M5E3U0v70HJ+tk2mqKtmPzwpXL8lUAxE4q
         80YgO6Fpyqf0EfoN3IevYMR7AQmJA1uWclFxS//uvE4+tUimZ0o5B5auQI5uD/izWBjB
         eNDqHbdusho1391M2bbRdEbSj2sL6Dd2tnd8yKJYCdGGyjnIyIXkpaSOY5cNqt0zznoL
         Yx8E7EFIx+tSdzrGYZiCmJy3XIxkY3yjCbOFaGkPWk61PYWeewpUnDIDMNl7ObcTTv4m
         ZFyA==
X-Forwarded-Encrypted: i=1; AHgh+RqJ0+kFe3L8brS4i+ncR7C7AO2MHthNScc0y73Faf90CvdPYp9tryf6FgEcapilYhcmQvjFdA82O7J5yGp5@vger.kernel.org
X-Gm-Message-State: AOJu0YxvNeO3/EnJeKgPgNpqFzSpNHDaoCAr9A+FEsUkpXcrFmzHLO+u
	mJtkFy0jGOm5fsY9wtsb/sb+fL07XPddiPedor2d06dX+WMp4fVDwxsEF1FdYtuRofs=
X-Gm-Gg: AR+sD10cNa6/hXUiBs5TGXz5Eqe5ul+T8sYmHIEPbAwvAu5LX+8r4HfieLau5DHxruv
	c5qqmBpYrgun5rPiaEHv9eM2c3PJrlkY47mq7OaO9UP0GNGc7pprUMWgAOLTOZheVljhoCLQL+9
	OTSfVVbXlDBbEG5D5xxVBR6d1A7oCGhXfAdL88axKJYuj0f7mkEcjmOeoVyfFr5hQPbIJXISgis
	Hdsx7b4+End07JNBJvR7uPx9JPT98nE3qAdB9vZmJrj8N36H+QW9I2fvijGHaFY+9+ZMWgLqRvm
	k5RydLM7+9x2s8q98PqUNNxF091YpLA04iBrqZhiWgc1hKg7vqx1Aw26y3L8dnZjOqyYGqUjk2h
	hLza/4JpwXxh6Tw0Vk5s6UPBsmd9gxPCf/Md7wcYtVJOvdDUkQwdzwkkxAwJ16WhmK24mqOXqaS
	eN9aEEkVlzHkCq4ac0NohTCTOx34wW5cflVqPG4jqCQCZqNp8go4ht6kjky1hDCfIIkQqTKPzOR
	Te7ZQ/lcMnTMvHBLRn3gmTdrZvLbtRTBedHpN7+Beh+Muj7dwnmFEYSgfKuEQS7biZPFZ/AK47B
	XIHI4H4bRcDbrY10Fg1pE4qfk8xrsDs=
X-Received: by 2002:a05:6000:43d4:10b0:47f:90df:4ec6 with SMTP id ffacd0b85a97d-47fd72a00bemr23693263f8f.6.1785773772893;
        Mon, 03 Aug 2026 09:16:12 -0700 (PDT)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100? (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41d0064sm33145217f8f.5.2026.08.03.09.16.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2026 09:16:12 -0700 (PDT)
Message-ID: <9979198f-95f8-4fa7-8f24-ef74585e2798@suse.com>
Date: Mon, 3 Aug 2026 18:16:11 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lib/bug: ignore non-allocated module bug tables
To: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260729174234.86242-1-acharyalaxman8848@gmail.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260729174234.86242-1-acharyalaxman8848@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/29/26 7:42 PM, Laxman Acharya Padhya wrote:
> rewrite_section_headers() initially sets sh_addr for every section to its
> address in the temporary module image. Only SHF_ALLOC sections are later
> copied to module memory and have sh_addr updated.
> 
> module_bug_finalize() accepts any section named __bug_table. A malformed
> module can therefore leave mod->bug_table pointing into the temporary
> image, which is freed after loading. A later BUG/WARN lookup would then
> scan freed memory.
> 
> Require the bug table section to be allocated before retaining its
> address. Valid modules are unchanged because __bug_table is allocated.
> 
> Fixes: 7664c5a1da47 ("[PATCH] Generic BUG implementation")
> Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
> ---
>  lib/bug.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/bug.c b/lib/bug.c
> index 7c1c2c27f..44966ead1 100644
> --- a/lib/bug.c
> +++ b/lib/bug.c
> @@ -94,7 +94,8 @@ void module_bug_finalize(const Elf_Ehdr *hdr, const Elf_Shdr *sechdrs,
>  	/* Find the __bug_table section, if present */
>  	secstrings = (char *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
>  	for (i = 1; i < hdr->e_shnum; i++) {
> -		if (strcmp(secstrings+sechdrs[i].sh_name, "__bug_table"))
> +		if (strcmp(secstrings + sechdrs[i].sh_name, "__bug_table") ||
> +		    !(sechdrs[i].sh_flags & SHF_ALLOC))
>  			continue;
>  		mod->bug_table = (void *) sechdrs[i].sh_addr;
>  		mod->num_bugs = sechdrs[i].sh_size / sizeof(struct bug_entry);

This change looks ok to me but I think it is not strictly necessary.

Loading a module should normally at least get through the signature and
blacklist checks without crashing due to a corrupted module ELF file.
After that point, I believe the ELF data should be trusted, similar to
how the actual module code is expected to be correct.

module_bug_finalize() is called fairly late in the module-loading
process, after the signature and blacklist checks.

-- 
Thanks,
Petr
