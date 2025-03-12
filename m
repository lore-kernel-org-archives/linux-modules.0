Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0694288BA
	for <linux-modules@vger.kernel.org>; Wed, 12 Mar 2025 15:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741794332; cv=none; b=ZGl9gHa48NakcbSp52Qu0QJ0gRQvB6IKAt2pivuPVqhq7CaAe4nqZHfDJBB11WRwY34ckkJbQ/JB3r15Hkk7R9jwiRniQahpRC4f8zGP28lCPOIfcvf4kPiDa/jf6Y7pAkDqKnRfPySevxhBHiONnEClXNdNZhPUe5TlVenGUtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741794332; c=relaxed/simple;
	bh=drMtDWOEa8mL65eG8MdXsGgCEPAFzQ+/rYSX1ummn5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SZQw6IgjUe99MEgPZHCqS/MFWg7AP/N5qg9INkv/OvMpNkx3GdEpSJbFVjm/VUz60XaCLRNzOV1Z/XFWD9RGyAxnf/34OrS+10hKqacg7wDuhwq7wDitVaSeWtWMQL3oA8caXfvppYfQPzVVVHmerlUSptq8kabflue5xIGAM/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=olXtCEfp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dLQuRPBm; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aVMdF2mR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AesxH4bi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="olXtCEfp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dLQuRPBm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aVMdF2mR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AesxH4bi"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E80A51F7F8;
	Wed, 12 Mar 2025 15:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741794328; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N3XwIXcy6Q4Evz4UAeNpQ3991S5L6PKz3XLAG/glkfk=;
	b=olXtCEfpeSorEzV45WKrZ2r2Ouq4IxAjOk3zB/seWjY8MIBeysk4Tqq8JbrJ5gfWM9uUKQ
	+CmhmzY7BFVMb+eIyYoRgj9FAAfhqXDVhX0c4sChXiFPF2oUf9EC91V5V+gxBDOoHBz84X
	1WfuaF/xvaFhCUHKQnkTTaGkvPg0f8Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741794328;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N3XwIXcy6Q4Evz4UAeNpQ3991S5L6PKz3XLAG/glkfk=;
	b=dLQuRPBmpsKyH26izDH0fetWpGa9I7gVDc6LEc5h4vneALykUgxmjddxucFQ9vw3zKZxEt
	0DK+1LGQFPxoOwCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741794324; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N3XwIXcy6Q4Evz4UAeNpQ3991S5L6PKz3XLAG/glkfk=;
	b=aVMdF2mRQrNVZet/OVwNGpXxby1ZBuUMaynUnBbUhe/aJQXEpqhlFKKHwlqLls2XWbz5Z9
	nJlPPBKUXjvtN1eU2JZzI1X4bSazeWe2wi4ykhc7jFADFggXcqoaABw4+eG5zIX3xbK46l
	xUB8v7JLQ3FEqXUP/pfzG86bctjl+/M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741794324;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N3XwIXcy6Q4Evz4UAeNpQ3991S5L6PKz3XLAG/glkfk=;
	b=AesxH4biFaIDiLv4SIhg0jG3C+ZftOWnl6Aka+Kfgl98OrHaHD0OTvuBp2Ahri/nclt/tf
	kaAwNxF9M9199DCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C947F1377F;
	Wed, 12 Mar 2025 15:45:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id P4LHMBSs0WfKEgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 12 Mar 2025 15:45:24 +0000
Message-ID: <c25939c5-d6e8-4450-873b-0a9c774b845b@suse.cz>
Date: Wed, 12 Mar 2025 16:45:24 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] module: Taint the kernel when write-protecting
 ro_after_init fails
Content-Language: en-US
To: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>
Cc: Sami Tolvanen <samitolvanen@google.com>,
 Daniel Gomez <da.gomez@samsung.com>, Kees Cook <kees@kernel.org>,
 Petr Mladek <pmladek@suse.com>, Jani Nikula <jani.nikula@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 John Ogness <john.ogness@linutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-mm <linux-mm@kvack.org>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250306103712.29549-1-petr.pavlu@suse.com>
 <Z8nT8PCPThnfb3Cq@bombadil.infradead.org>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <Z8nT8PCPThnfb3Cq@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	URIBL_BLOCKED(0.00)[suse.cz:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 3/6/25 17:57, Luis Chamberlain wrote:
> + linux-mm since we're adding TAINT_BAD_PAGE
> 
> On Thu, Mar 06, 2025 at 11:36:55AM +0100, Petr Pavlu wrote:
>> In the unlikely case that setting ro_after_init data to read-only fails, it
>> is too late to cancel loading of the module. The loader then issues only
>> a warning about the situation. Given that this reduces the kernel's
>> protection, it was suggested to make the failure more visible by tainting
>> the kernel.
>> 
>> Allow TAINT_BAD_PAGE to be set per-module and use it in this case. The flag
>> is set in similar situations and has the following description in
>> Documentation/admin-guide/tainted-kernels.rst: "bad page referenced or some
>> unexpected page flags".
>> 
>> Adjust the warning that reports the failure to avoid references to internal
>> functions and to add information about the kernel being tainted, both to
>> match the style of other messages in the file. Additionally, merge the
>> message on a single line because checkpatch.pl recommends that for the
>> ability to grep for the string.
>> 
>> Suggested-by: Kees Cook <kees@kernel.org>
>> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
>> ---
>> I opted to use TAINT_BAD_PAGE for now because it seemed unnecessary to me
>> to introduce a new flag only for this specific case. However, if we end up
>> similarly checking set_memory_*() in the boot context, a separate flag
>> would be probably better.
>> ---
>>  kernel/module/main.c | 7 ++++---
>>  kernel/panic.c       | 2 +-
>>  2 files changed, 5 insertions(+), 4 deletions(-)
>> 
>> diff --git a/kernel/module/main.c b/kernel/module/main.c
>> index 1fb9ad289a6f..8f424a107b92 100644
>> --- a/kernel/module/main.c
>> +++ b/kernel/module/main.c
>> @@ -3030,10 +3030,11 @@ static noinline int do_init_module(struct module *mod)
>>  	rcu_assign_pointer(mod->kallsyms, &mod->core_kallsyms);
>>  #endif
>>  	ret = module_enable_rodata_ro_after_init(mod);
>> -	if (ret)
>> -		pr_warn("%s: module_enable_rodata_ro_after_init() returned %d, "
>> -			"ro_after_init data might still be writable\n",
>> +	if (ret) {
>> +		pr_warn("%s: write-protecting ro_after_init data failed with %d, the data might still be writable - tainting kernel\n",
>>  			mod->name, ret);
>> +		add_taint_module(mod, TAINT_BAD_PAGE, LOCKDEP_STILL_OK);
>> +	}
>>  
>>  	mod_tree_remove_init(mod);
>>  	module_arch_freeing_init(mod);
>> diff --git a/kernel/panic.c b/kernel/panic.c
>> index d8635d5cecb2..794c443bfb5c 100644
>> --- a/kernel/panic.c
>> +++ b/kernel/panic.c
>> @@ -497,7 +497,7 @@ const struct taint_flag taint_flags[TAINT_FLAGS_COUNT] = {
>>  	TAINT_FLAG(CPU_OUT_OF_SPEC,		'S', ' ', false),
>>  	TAINT_FLAG(FORCED_RMMOD,		'R', ' ', false),
>>  	TAINT_FLAG(MACHINE_CHECK,		'M', ' ', false),
>> -	TAINT_FLAG(BAD_PAGE,			'B', ' ', false),
>> +	TAINT_FLAG(BAD_PAGE,			'B', ' ', true),
>>  	TAINT_FLAG(USER,			'U', ' ', false),
>>  	TAINT_FLAG(DIE,				'D', ' ', false),
>>  	TAINT_FLAG(OVERRIDDEN_ACPI_TABLE,	'A', ' ', false),
> 
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> 
> For our needs this makes sense, however I am curious if TAINT_BAD_PAGE
> is too broadly generic, and also if we're going to add it, if there are
> other mm uses for such a thing.

I'm not sure BAD_PAGE is a good fit. If there was a new flag that meant "a
hardening measure failed", would that have other possible uses? The
semantics would be that the kernel self-protection was weakened wrt
expectations, even if not yet a corruption due to attack would be detected.
Some admins could opt-in to panic in such case anyway, etc. Any other
hardening features where such "failure to harden" is possible and could use
this too? Kees?

>   Luis
> 

