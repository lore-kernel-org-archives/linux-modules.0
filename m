Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E5C34E74E
	for <linux-modules@vger.kernel.org>; Wed,  4 Mar 2026 16:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772640767; cv=none; b=UKx6HLnlFny6h/sR5B5usM4JeVHY8HtQlAI24m8+Rwf6VZt8m+ltdbcSwJ2UeGvQ6cNynOLMRE7RWxzuYRhC05npE4DjRVLma3JL8MTRWuMzXZ6eLUs5uhaIIFBcleAcDTDUNhU+qMVNFnw1sMTc8/6Ng6oCLDbMTo8ekqw/fwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772640767; c=relaxed/simple;
	bh=m+qwbB71rrlGhNdXzKE/AQ50HEHKr9xwlau/dwXUUzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CjqvXG3jlHHBolSgq3mjliJ62FrjZHIeaXws8pdT8B3i7vl5yey6mZEX9CW2AZQ9a9ZVGHKQXYPbvJDZAolL9iJFdOc4MSqXZqnUa7UBuBVDmOyPHXg0NwdAPDOqcBD/pfdP+IZdP98EuiEbY97LzaIegu9Z+1mfOhViR04tjIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MmX9vs4Z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MmX9vs4Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772640764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GOOCbZ9poJVCD4GALeTPjjenC3XBTD2PBklGLSe4XRQ=;
	b=MmX9vs4Z8TJfXC2HuB0s0zHWxa3N8CJsO0ZSULzyIC4lf9dWOPejtEWbcpvG20zHyklPTV
	jRTMuYin3ijKLPsizo68iri5IsJINhKstC+PAQA7PKUkVPRdT7AoRuDZajHQ8XBaxq+2hS
	nLnJhPPVJIavJEN1x/Acj7wrBli5DoI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-W_XQERGnNeSaGneBfH7G1Q-1; Wed,
 04 Mar 2026 11:12:39 -0500
X-MC-Unique: W_XQERGnNeSaGneBfH7G1Q-1
X-Mimecast-MFC-AGG-ID: W_XQERGnNeSaGneBfH7G1Q_1772640757
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5C69619560B0;
	Wed,  4 Mar 2026 16:12:37 +0000 (UTC)
Received: from redhat.com (unknown [10.22.80.5])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 40E5C19560AB;
	Wed,  4 Mar 2026 16:12:35 +0000 (UTC)
Date: Wed, 4 Mar 2026 11:12:32 -0500
From: Joe Lawrence <joe.lawrence@redhat.com>
To: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>, Petr Mladek <pmladek@suse.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: [PATCH] module.lds: force 0 sh_addr for .text, .data, .bss, and
 .rodata sections
Message-ID: <aahZ8K6BmtVKRbg2@redhat.com>
References: <20260304160611.143862-1-joe.lawrence@redhat.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304160611.143862-1-joe.lawrence@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Wed, Mar 04, 2026 at 11:06:11AM -0500, Joe Lawrence wrote:
> Commit 1ba9f8979426 ("vmlinux.lds: Unify TEXT_MAIN, DATA_MAIN, and
> related macros") added .text and made .data, .bss, and .rodata sections
> unconditional in the module linker script, but without an explicit
> address like the other sections in the same file.
> 
> When linking modules with ld.bfd -r, sections defined without an address
> inherit the location counter, resulting in non-zero sh_addr values in
> the .ko.  Relocatable objects are expected to have sh_addr=0 for these
> sections and these non-zero addresses confuse elfutils and have been
> reported to cause segmentation faults in SystemTap [1].
> 
> Add the 0 address specifier to .text, .bss, .data, and .rodata, and also
> to __patchable_function_entries and __kcfi_traps which had the same
> issue.
> 
> Link: https://sourceware.org/bugzilla/show_bug.cgi?id=33958
> Fixes: 1ba9f8979426 ("vmlinux.lds: Unify TEXT_MAIN, DATA_MAIN, and related macros")
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
> ---
>  scripts/module.lds.S | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/scripts/module.lds.S b/scripts/module.lds.S
> index 054ef99e8288..e1cab3cee3f7 100644
> --- a/scripts/module.lds.S
> +++ b/scripts/module.lds.S
> @@ -32,30 +32,30 @@ SECTIONS {
>  	__jump_table		0 : ALIGN(8) { KEEP(*(__jump_table)) }
>  	__ex_table		0 : ALIGN(4) { KEEP(*(__ex_table)) }
>  
> -	__patchable_function_entries : { *(__patchable_function_entries) }
> +	__patchable_function_entries 0 : { *(__patchable_function_entries) }
>  
>  	.init.klp_funcs		0 : ALIGN(8) { KEEP(*(.init.klp_funcs)) }
>  	.init.klp_objects	0 : ALIGN(8) { KEEP(*(.init.klp_objects)) }
>  
>  #ifdef CONFIG_ARCH_USES_CFI_TRAPS
> -	__kcfi_traps		: { KEEP(*(.kcfi_traps)) }
> +	__kcfi_traps		0 : { KEEP(*(.kcfi_traps)) }
>  #endif
>  
> -	.text : {
> +	.text			0 : {
>  		*(.text .text.[0-9a-zA-Z_]*)
>  	}
>  
> -	.bss : {
> +	.bss			0 : {
>  		*(.bss .bss.[0-9a-zA-Z_]*)
>  		*(.bss..L*)
>  	}
>  
> -	.data : {
> +	.data			0 : {
>  		*(.data .data.[0-9a-zA-Z_]*)
>  		*(.data..L*)
>  	}
>  
> -	.rodata : {
> +	.rodata			0 : {
>  		*(.rodata .rodata.[0-9a-zA-Z_]*)
>  		*(.rodata..L*)
>  	}
> -- 
> 2.53.0
> 

Linker files are not my usual gig, but I offer up this patch as a
strawman to raise awareness to those who might know better :D

This was very lightly tested: readelf reports 0 sh_addrs after the
change for the affected sections and stap was happier parsing this.

Thanks,
--
Joe

