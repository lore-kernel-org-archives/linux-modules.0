Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3537B16130C;
	Thu,  6 Mar 2025 17:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741283406; cv=none; b=Fwa22Iez/J5fe9FaymaDsfAV/JCXKP+Wf5iQZ+NoY476cLfVmSZ2hf+kBBjd2vhnEY45EUVUSAYFp/nZw//RCOWYAYurckTN7LfS0Hhxl7PPhu+PDTHp5gVJIhihaE8ccwvVhsTbDFsRpWd/WY5y3M7jb3SAQb+JyvNIqqfO0V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741283406; c=relaxed/simple;
	bh=x1XoYdOx/gYcoUR3hT9TCku6gQ7eFxbTIQOY5Da/ErQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uv1Q1hRLQHA/7uX1Knt3ivSyJxDrA/Wv4/8L+apDP3v921oAxsY8d71h+QoOTgkcMdzHvsaIiQMZMFySMpPk/IpVkYjK+cLEwD8dsInRiuklTGpEz6AHqZHZf1gesxpEzlR3m5OxDgmMz8FfJKPujOcuDbVC1pzn1zUkkv0hYg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Z7xGz3ljwz9stM;
	Thu,  6 Mar 2025 18:28:59 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j75WxZwarWB9; Thu,  6 Mar 2025 18:28:59 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Z7xGz2wQTz9stL;
	Thu,  6 Mar 2025 18:28:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 4FAE48B77B;
	Thu,  6 Mar 2025 18:28:59 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 0nXO3ADxucWW; Thu,  6 Mar 2025 18:28:59 +0100 (CET)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id BDF6D8B76C;
	Thu,  6 Mar 2025 18:28:58 +0100 (CET)
Message-ID: <481a3ef9-6d4e-4e29-9d50-a6338604c873@csgroup.eu>
Date: Thu, 6 Mar 2025 18:28:58 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] module: Make .static_call_sites read-only after
 init
To: Petr Pavlu <petr.pavlu@suse.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Jason Baron <jbaron@akamai.com>
Cc: Sami Tolvanen <samitolvanen@google.com>,
 Daniel Gomez <da.gomez@samsung.com>, Steven Rostedt <rostedt@goodmis.org>,
 Ard Biesheuvel <ardb@kernel.org>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250306131430.7016-1-petr.pavlu@suse.com>
 <20250306131430.7016-4-petr.pavlu@suse.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20250306131430.7016-4-petr.pavlu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 06/03/2025 à 14:13, Petr Pavlu a écrit :
> Section .static_call_sites holds data structures that need to be sorted and
> processed only at module load time. This initial processing happens in
> static_call_add_module(), which is invoked as a callback to the
> MODULE_STATE_COMING notification from prepare_coming_module().
> 
> The section is never modified afterwards. Make it therefore read-only after
> module initialization to avoid any (non-)accidental modifications.

Maybe this suggestion is stupid, I didn't investigate the feasability 
but: why don't we group everything that is ro_after_init in a single 
section just like we do in vmlinux ? That would avoid having to add 
every new possible section in the C code.

Like we have in asm-generic/vmlinux.lds.h:

#define RO_AFTER_INIT_DATA						\
	. = ALIGN(8);							\
	__start_ro_after_init = .;					\
	*(.data..ro_after_init)						\
	JUMP_TABLE_DATA							\
	STATIC_CALL_DATA						\
	__end_ro_after_init = .;


> 
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> ---
>   kernel/module/strict_rwx.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/kernel/module/strict_rwx.c b/kernel/module/strict_rwx.c
> index fa701dad4ed1..a3fc8d603750 100644
> --- a/kernel/module/strict_rwx.c
> +++ b/kernel/module/strict_rwx.c
> @@ -120,6 +120,15 @@ static const char *const ro_after_init[] = {
>   	 * section, which are marked as such at module load time.
>   	 */
>   	"__jump_table",
> +
> +#ifdef CONFIG_HAVE_STATIC_CALL_INLINE
> +	/*
> +	 * Section .static_call_sites holds data structures that need to be
> +	 * sorted and processed at module load time but are never modified
> +	 * afterwards.
> +	 */
> +	".static_call_sites",
> +#endif
>   };
>   
>   void module_mark_ro_after_init(const Elf_Ehdr *hdr, Elf_Shdr *sechdrs,

