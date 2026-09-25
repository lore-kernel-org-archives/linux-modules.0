Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A5F46D551;
	Fri, 25 Sep 2026 12:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790339811; cv=none; b=SsJM88JE1cvJQb97yhLfcn0ON2aOxOWkxo+en1bpDYXYuHY2fjmaJSYtVIf7EgHSRXT5NdGr50LDuuz6fIh2siez7SXOR8zIDP/ZCFEIqffBQdf3+lIp4vawbnkToCLswMDgCWAmFiyBish09euJfXXNh1gqDXS4C/JlZ8qydIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790339811; c=relaxed/simple;
	bh=P8A4+Z5vOanFOaPLgNfl0mrEegSjtkFlrCupnu7Ts8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pK48gpoum+3l3uAb8My25I9UjThZLwPZ0EJv2wXJgj57UcHz+vlSSXnJZDUDTeoHDhEHaAMmtCfw9B1MIf0lr0O1uLYAP9aCRSsIquTK8Zd0YfJp9gPYiSMqe4UadaHd53+ljeXNC+naC8dy3w9cJ4+Ln9SulRaM/F8f7ZuXAGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WHm0v3by; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=w4f4k4HJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qliJyqv6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qSXwyh5g; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WHm0v3by";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="w4f4k4HJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qliJyqv6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qSXwyh5g"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B4E281FF19;
	Fri, 25 Sep 2026 12:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790339803; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5PQD/gP9HcwZvTFe4S+U8lCpH3yLiPZ8vm6DacsXn1I=;
	b=WHm0v3byaFwQe+OkzjsJkiuJOsh779o1q6qJ9mu7zU9TBWkziuN9dAgyiUfG15y2SiL45+
	jFuX5RqjS5zes6XH0jcLzt4k8topgVmk6gdtbxbqP58vnn05IuHO5b2KvVqwWCTp5Z4pML
	xY9x8KweRrDU4aJnLbZydS/i4GiE8XA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790339803;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5PQD/gP9HcwZvTFe4S+U8lCpH3yLiPZ8vm6DacsXn1I=;
	b=w4f4k4HJUBTcOmoQC9olN6gCIJ+cr0d/SKzRJCgwQda0D/zG3DQUsU4loREAsVSKhmXP9r
	kQBYKNYUUJWxMhCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=qliJyqv6;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=qSXwyh5g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790339799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5PQD/gP9HcwZvTFe4S+U8lCpH3yLiPZ8vm6DacsXn1I=;
	b=qliJyqv6wcyiqIATiE0jrio8qNFyOT+OqCP635IH1AsIhiTAI3MPMcFRvApQbbV4hN9fZH
	dwfne3zCzBB6fLKySMqm3h4L3PGfyPrZh0i/okP2fA+8nwKKQwjBb4JarlEsUka0KKTDAF
	ElDh+brNb35L5Dd8f9aPd1r/4UJa5h8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790339799;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5PQD/gP9HcwZvTFe4S+U8lCpH3yLiPZ8vm6DacsXn1I=;
	b=qSXwyh5gBuBmidY46MUu9I2enCpz3zW4oCEJP1Erpuf/7S1r0aHoC+1ClezRy4s2/UeoI/
	415v78ZGnCWQPiCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 70B3713432;
	Fri, 25 Sep 2026 12:36:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4A4UEtdqtmqxdQAAD6G6ig
	(envelope-from <ppavlu@suse.cz>); Fri, 25 Sep 2026 12:36:39 +0000
Message-ID: <0ecdcba9-a0a5-456f-8d30-e2201828cd07@suse.cz>
Date: Fri, 25 Sep 2026 14:36:39 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: macros: allow non-ASCII characters in `authors`
To: Gary Guo <gary@garyguo.net>
Cc: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>,
 Miguel Ojeda <ojeda@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 rust-for-linux@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260917051147.98775-1-tweek@google.com>
 <DLHERMQ9DOIC.1TRR4M82WNLIZ@garyguo.net>
Content-Language: en-US
From: Petr Pavlu <ppavlu@suse.cz>
In-Reply-To: <DLHERMQ9DOIC.1TRR4M82WNLIZ@garyguo.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B4E281FF19
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Score: -4.51

On 9/17/26 9:20 AM, Gary Guo wrote:
> On Thu Sep 17, 2026 at 6:11 AM BST, =?UTF-8?q?Thi=C3=A9baud=20Weksteen?= wrote:
>> Module authors may have non-ASCII characters in their names. In C,
>> `MODULE_AUTHOR` allows arbitrary string literals which are emitted as
>> raw UTF-8 bytes into the `.modinfo` section, and multiple in-tree
>> modules use non-ASCII author names.
>>
>> Originally, the single `author` field permitted arbitrary string literals
>> including non-ASCII characters. When support for multiple authors was
>> introduced in commit 38559da6afb2 ("rust: module: introduce `authors`
>> key"), it reused the `expect_string_array` helper that had originally been
>> added for module aliases. Because that helper enforced an ASCII check,
>> `authors` inadvertently became restricted to ASCII-only string literals.
>> Later, when the macro parsing was rewritten to use `syn` in commit
>> c578ad703ae9 ("rust: macros: use `syn` to parse `module!` macro"), this
>> restriction was carried over by using AsciiLitStr in `authors` type.
>>
>> Change the element type of `authors` in `ModuleInfo` from `AsciiLitStr`
>> to `LitStr` so that UTF-8 author names are permitted.
>>
>> Fixes: 38559da6afb2 ("rust: module: introduce `authors` key")
>> Signed-off-by: Thiébaud Weksteen <tweek@google.com>
> 
> Off topic, but I have a question for modules maintainers...
> 
> Does the `authors` field still serve this purpose today?
> 
> Almost always it is just the initial submitter, while the code has been subject
> to many changes (many of them tree wide too), and the maintainers could have
> changed as well.
> 
> We have copyright comments on top of files, and git for checking the file
> history. What's the point of keeping his inside module metadata?

MODULE_AUTHOR() was apparently added in 2.1.18 back in 1996 [1], with
a comment that it is for documentation purposes.

I don't have a full picture of how this modinfo field is currently used
by module authors, maintainers and users. I think it can be useful as
a record of all past and present primary authors of a specific module,
and it has also value for external modules. Unlike copyright statements
and Git history, the information is directly visible to users through
the modinfo utility.

It is up to individual module maintainers whether they want to use this
field and maintain its information. The module loader doesn't enforce
its setting in any way.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/mpe/linux-fullhistory.git/commit/?id=e69db0c2dafd9206cdc859b0361c6d4f07d77676

-- 
Cheers,
Petr
