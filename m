Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801BB21576E;
	Fri, 17 Oct 2025 17:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760722709; cv=none; b=Njq0OfF4FqT9kGF4/v5Ws2cMrlKNQWn8LTjvBu51ECenpQUEXBycU14gjYz9UdyGDJAOrM8MAo6N3p7lTV391Hp0FE6r8VPvubnJKrxqBsAmkXSJyG7AgrUSOG7rMOqi3HNuQFTr0qJHZCtUO9kzsEHZHMEoMbvO7ANfBww566c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760722709; c=relaxed/simple;
	bh=3HdUj0gn3DEUrSYbt10rDq3r6Cxde9MHzvEbHk7eiaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aErCj+CdJX9009/qiWCH8Pfpovvj9F4aQB88eJtv50Qi+KnQIzAVdiVWegdqWB9D6gCUuiGc8euFjIUD//9+v0G6wrsoj4hDli3nEqp/QcTv9UqmNdYBrJ/2dwr3tcMqlg5LMxv4shl8A8lQFrRz5LjCjgkc6JF/THYNJXdR35w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZnZFgIjf; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZnZFgIjf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=eXk8ilpgowFnp9IUDy5Nr5norSdI0m1xretE6+YcfLo=; b=ZnZFgIjfWC6Jy5gtsRj/XVDZdp
	e2UDDYPl/gO2hlfkL2zJOaCYJphiT0ihkWpBMtfUT2Q70+ygu/F1s4UOJy9vNgy9BwXoibiEZjeHT
	LgUXmf9UIln9fQLd1BhUQTPeWXweOFGeFD6+1xdFryktjmBXRw7luR7OabyYvjIj72wZMAhCpFWQ5
	fExo5n+eeRiLwUVlFdBCtv/2UbNhrQhstf62ZODZ3dw2yu48n4WSq51PBdf8R5x/R9oYQPNC55mli
	RVs4GLQXe23d74e5RsovgtJz7te0QfQyHOVeP1gwGCG81eQhnCwTMdYp2U8LwqSGu0mhqw1ehmcUt
	a7wgUIlg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9oPL-00000008c4b-2fU7;
	Fri, 17 Oct 2025 17:38:27 +0000
Message-ID: <7e793098-ff46-4840-a5e0-18c42ae1c145@infradead.org>
Date: Fri, 17 Oct 2025 10:38:27 -0700
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: ABI: sysfs-module: list all taint flags
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, linux-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org
References: <20251015221348.1125295-1-rdunlap@infradead.org>
 <c58152f1-0fbe-4f50-bb61-e2f4c0584025@suse.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <c58152f1-0fbe-4f50-bb61-e2f4c0584025@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/17/25 4:38 AM, Petr Pavlu wrote:
> On 10/16/25 12:13 AM, Randy Dunlap wrote:
>> The list of module taint flags has not been updated lately as the
>> taint flags list grows. Instead of trying to keep multiple lists
>> updated, just refer to the list of kernel taint flags since they are
>> the same.
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> ---
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: linux-doc@vger.kernel.org
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Luis Chamberlain <mcgrof@kernel.org>
>> Cc: Petr Pavlu <petr.pavlu@suse.com>
>> Cc: Daniel Gomez <da.gomez@kernel.org>
>> Cc: Sami Tolvanen <samitolvanen@google.com>
>> Cc: linux-modules@vger.kernel.org
>> ---
>>  Documentation/ABI/testing/sysfs-module        |   10 ++--------
>>  Documentation/admin-guide/tainted-kernels.rst |    2 ++
>>  2 files changed, 4 insertions(+), 8 deletions(-)
>>
>> --- linux-next-20251014.orig/Documentation/ABI/testing/sysfs-module
>> +++ linux-next-20251014/Documentation/ABI/testing/sysfs-module
>> @@ -52,14 +52,8 @@ What:		/sys/module/*/taint
>>  Date:		Jan 2012
>>  KernelVersion:	3.3
>>  Contact:	Kay Sievers <kay.sievers@vrfy.org>
>> -Description:	Module taint flags:
>> -			==  =====================
>> -			P   proprietary module
>> -			O   out-of-tree module
>> -			F   force-loaded module
>> -			C   staging driver module
>> -			E   unsigned module
>> -			==  =====================
>> +Description:	Module taint flags: same as the kernel taint flags.
>> +		See: :ref:`taint_flags` in Documentation/admin-guide/tainted-kernels.rst
> 
> The module taint flags that can appear in /sys/module/*/taint are
> a subset of the kernel taint flags. By looking at the calls to
> add_taint_module(), they are as follows:
> 
> Present:
> TAINT_PROPRIETARY_MODULE
> TAINT_OOT_MODULE
> TAINT_FORCED_MODULE
> TAINT_CRAP
> TAINT_UNSIGNED_MODULE
> 
> Missing:
> TAINT_LIVEPATCH
> TAINT_TEST
> 
> + potentially TEST_AUX.
> 
> Since this text specifically documents what can appear in
> /sys/module/*/taint, I think we should still maintain a list of these
> flags for accuracy.
> 
> Additionally, Documentation/admin-guide/tainted-kernels.rst provides
> taint descriptions for the kernel as a whole, which can be misleading
> for individual modules. For instance, for TAINT_LIVEPATCH, the document
> says "kernel has been live patched", but in the context of
> /sys/module/*/taint, it means "this is a livepatch module".


Hi Petr,

Thank you for your comments and corrections.

I'll drop this patch.

-- 
~Randy

