Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429AE479898;
	Thu,  6 Aug 2026 12:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786018687; cv=none; b=E8/JfiK2FpjetDzalfitrBhPtus2RzE3uUitQ/Ap0c01G6B/iuW5jsms+3imjbWnGFBnm7enzYL8EPgjCf52LWyJqAwpsbA2q5s9WpbzFur3mmmQQoH1RtjDcvGdo/pAzc/+rhkexJT9Lq/DU8zkV3T5g+upogDo6N1DnbQJq3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786018687; c=relaxed/simple;
	bh=a59tCBSiwDAgxqT+9CORHIc8FUi4XfEJwdVI5pozH5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pm9qHmjCrTfmsuocYIkLBdJWvurQgX4Lgceqa3WBO304+CU7NtLBubOsq4ZRUs6gCo/fcZ8n0x+/36kOEzjq5IH8Nh55WRQ5OINiVsBbpk+bs5+xUzD3RsEfBk0UKMmcgisikX8WAmpADCGz6Rem1GZsPeC4iHjxFSHtOkgfuUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=HDXpwfFp; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fotg7s1/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HDXpwfFp";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fotg7s1/"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0CF2C80019;
	Thu,  6 Aug 2026 12:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1786018679; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EiqqOWSQ88lyE58JWZboQ9pCSZEbQYazF7pcIIHtxdE=;
	b=HDXpwfFpj2zQbTpYAY6bcWrw1d71FTXTWdhYonv1TbMbsSqw8vJFs4dkApiyPoa+5r8YP5
	VXCRMd/4/aBi/GvIN6mA/cAOMk5+/ekBVQUEtKH20aRNh5tM9YvKz0/DIt+tLj/B4TXIy6
	qMUTm95Gqyd7kL5GWiMZgeIZqNh/ras=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="fotg7s1/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1786018675; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EiqqOWSQ88lyE58JWZboQ9pCSZEbQYazF7pcIIHtxdE=;
	b=fotg7s1/sTDfsp5NWvhudIAtyhjmAzMhUpHcv//MmVm5e9hCbVkrzKNpzdzFrmDr3Mee0t
	49VwdWr6aEOb6F2MzUS2J8wuHqFHFcyHkLP960mxeWG9fXJ0FbR88e1FC6yTn28Uamq0Jn
	KR1vEbtrnMj8tffy7pazr8GmH0aYR0Q=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ED10B779B6;
	Thu,  6 Aug 2026 12:17:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id S+bnNHJ7dGqnVAAAD6G6ig
	(envelope-from <petr.pavlu@suse.com>); Thu, 06 Aug 2026 12:17:54 +0000
Message-ID: <09ae4565-f013-4cfa-bbdc-4523a3a313a4@suse.com>
Date: Thu, 6 Aug 2026 14:17:46 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] module: validate string table section types
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 Siddharth Nayyar <sidnayyar@google.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260708012107.1621513-1-tweek@google.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260708012107.1621513-1-tweek@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 0CF2C80019
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:mid,suse.com:dkim];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

On 7/8/26 3:21 AM, Thiébaud Weksteen wrote:
> In elf_validity_cache_sechdrs, section sizes and offsets are validated,
> unless the section type is SHT_NULL or SHT_NOBITS.
> 
> Later, elf_validity_cache_secstrings and elf_validity_cache_index_str
> access the section name table (.shstrtab) and symbol string table
> (.strtab) headers without first ensuring that their types are
> SHT_STRTAB. If a section type is SHT_NULL or SHT_NOBITS, sh_offset has
> not been validated and may reference out-of-bounds memory when
> dereferenced in elf_validity_cache_secstrings or
> elf_validity_cache_strtab.
> 
> Validate that both string section headers are of type SHT_STRTAB before
> caching them.
> 
> Signed-off-by: Thiébaud Weksteen <tweek@google.com>

I've queued the patch on modules-next for v7.3-rc1.

-- 
Thanks,
Petr
