Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483F52F28EA;
	Sat, 14 Mar 2026 10:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773483748; cv=none; b=HpqeZ/TvIBgo5QUxIeu5/qTdU2YqrBCt6Bkgtl+X516zgj4dVpVijubyji+3YD0Kkz6Q76OEkQwTuaRpd0Fan7uJFMf+Oz36tR3qD4sWXDUXmieGb6AFAARfFbSrEZYaHuPlTR8UnsNARPXsmCCtLNOxrtgyMCOrua1f2Yyw9PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773483748; c=relaxed/simple;
	bh=yTeGSQ/1qS+mbhB1q7a6hGkNWeL94VYREJ0fxpR9dq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fomV4WiyD+Dcl6SiaHl+w/fLqygRq9KKLzZRgEUkcCY6pZBCurDE4Ux85B2LjLGsGomdY6XK8tjQDgkrSQkUtXq5oPobUUkGC/dqya5oy92hUMpET1ZFB7jBq+h8Ey4SG+9ZFQf9YNj0WZS0L9n9nQEB3ZEdxcXrbgz1dgSUICE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMf6qgpC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMf6qgpC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96A05C116C6;
	Sat, 14 Mar 2026 10:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773483747;
	bh=yTeGSQ/1qS+mbhB1q7a6hGkNWeL94VYREJ0fxpR9dq0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gMf6qgpCB5NAq4HfE9el8ZNztB+5R0uNotvO8Yk1E6G/3+M+IWFgsaj6m9ShjXdUL
	 qXS67QpDNhUnZC20C7PPWArgJzl3SpT4cemQdcSiSYZRJ+1fmYIGJoDE4r9oHDH7Ml
	 dXUXk8NU7OFZU3Td1zBTQ6w3i+NO+NIJeOk5vIOm72ooBBWZqAFAwiEPPkdSkUzZKq
	 abattNfmMX1FiMz6eFYFHieHkGZJYQqLwOuX1F7wlEndw3UAt5Jgpb94APMoDRVOH/
	 4WmDPg6SC4ios2vd2X77LAmkD9Cw+XT8iw7uGpPITuzu+1AUC7zNWdDBIrYqHAFqdg
	 w1tnucHexli1g==
Message-ID: <f036410e-f53c-4284-b108-18bcdb2f0d28@kernel.org>
Date: Sat, 14 Mar 2026 11:22:22 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] module: remove MODULE_VERSION()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 Shyam Saini <shyamsaini@linux.microsoft.com>, Kees Cook <kees@kernel.org>,
 Thorsten Blum <thorsten.blum@linux.dev>,
 Christoph Hellwig <hch@infradead.org>
References: <2026031341-evolve-repeater-987b@gregkh>
 <2026031303-prelaunch-creation-3fce@gregkh>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <2026031303-prelaunch-creation-3fce@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 13/03/2026 à 16:46, Greg Kroah-Hartman a écrit :
> On Fri, Mar 13, 2026 at 03:20:42PM +0100, Greg Kroah-Hartman wrote:
>> Module "versions" do not make sense as the kernel is built all at once,
>> the "version" is the overall kernel version number, so modules can not
>> really be described as having a unique version given that they rely on
>> the infrastructure of the whole kernel.
>>
>> For now, just make this an "empty" define, to keep existing code
>> building properly as the tree is slowly purged of the use of this over
>> time.
>>
>> This macro will be removed entirely in the future when there are no
>> in-tree users.
>>
>> Cc: Luis Chamberlain <mcgrof@kernel.org>
>> Cc: Petr Pavlu <petr.pavlu@suse.com>
>> Cc: Daniel Gomez <da.gomez@kernel.org>
>> Cc: Sami Tolvanen <samitolvanen@google.com>
>> Cc: Aaron Tomlin <atomlin@atomlin.com>
>> Cc: Shyam Saini <shyamsaini@linux.microsoft.com>
>> Cc: Kees Cook <kees@kernel.org>
>> Cc: Thorsten Blum <thorsten.blum@linux.dev>
>> Cc: Christoph Hellwig <hch@infradead.org>
>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> ---
>>   include/linux/module.h | 56 +++++++++---------------------------------
>>   kernel/params.c        | 30 ----------------------
>>   2 files changed, 11 insertions(+), 75 deletions(-)
> 
> 
> Sami just pointed out to me off-list that maybe I should also drop the
> srcversion stuff too.  I'll gladly do that too, does anyone know if
> anyone even uses that anymore?

If I understand correctly the text in kernel/module/Kconfig, srcversion 
is added only for modules which contain a MODULE_VERSION.

So as you drop MODULE_VERSION, srcversion becomes completely useless 
doesn't it ?

Christophe

