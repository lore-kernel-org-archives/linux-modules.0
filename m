Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4065A24B28;
	Sat,  9 May 2026 01:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778290816; cv=none; b=mat11ovrNhSZuo4wpYiaPdcSwjawsSgfmrGtIpraLe8z5LU5xNd79cp8S0cdrEgxdVEgZ9/1FsAMshHtoyS3+bkxEuR4bOAUMsp/cJyGyHwuXf3EMYv8iZiAgEPVhWGewdXKzHKLPmkd1WV/YydFYqM2Y1eUyb1tHgjZgTpI/I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778290816; c=relaxed/simple;
	bh=TUFTog92tEeX98e78g00IQMeZ8O7lXVqGfZNQakNPYY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=NYlvxDKFulwNQ3vqkfl44k5Qv5qCsz2RwRBh2JRn9ejr3VxZ0DLHWrZPzs3zkrPOkZW5gFg9EIInBAFe1szCgDOjZBEjp9dXzMZYXKsfzzY0PD8qE7tvBtgH1KaPuJCBteeLDAsy7xcKfmmUI7PMKVPQOZIfZMyrrmS0YGTK2Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WKtpfPY1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WKtpfPY1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67AA7C2BCB0;
	Sat,  9 May 2026 01:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1778290815;
	bh=TUFTog92tEeX98e78g00IQMeZ8O7lXVqGfZNQakNPYY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WKtpfPY1r/HZvGYFDOshFwM8nDuqgoa2GYqBTIqvhwgl/CgLb97xjAPDvdL0ywVyS
	 SQVOv9gt2RnWWXcmNeM5h5T6IOH4rhwROVJxKdMLOb3GDIUV8L3KUaAKxLtLY6iKdf
	 gFKa9Pzp7gGHAFyKs2XoyyQO6+wbADehQ7/TsMlQ=
Date: Fri, 8 May 2026 18:40:14 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jim Cromie <jim.cromie@gmail.com>
Cc: Jason Baron <jbaron@akamai.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, Sami
 Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 Shuah Khan <shuah@kernel.org>, Louis Chauvet <louis.chauvet@bootlin.com>,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-kselftest@vger.kernel.org, =?UTF-8?Q?=C5=81ukasz?= Bartosik
 <ukaszb@chromium.org>
Subject: Re: [PATCH 00/17] dynamic-debug cleanups refactors maintenance
Message-Id: <20260508184014.c8a7f718c7b221701829762b@linux-foundation.org>
In-Reply-To: <20260504-dd-cleanups-2-v1-0-6fdd24040642@gmail.com>
References: <20260504-dd-cleanups-2-v1-0-6fdd24040642@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 04 May 2026 14:45:06 -0600 Jim Cromie <jim.cromie@gmail.com> wrote:

> This series is nearly all maintenance: it refactors/splits functions,
> tightens an internal callchain, drops linked-listing where an
> array,length is already available, reduces verbose=3 logging for
> usability, and reorganizes several structs for better organization.
> 
> Getting these into linux-next for integration testing would clear the
> deck for fixing Dynamic-debug classmaps, which is needed to restore
> the un-BROKEN status of DRM_USE_DYNAMIC_DEBUG.
> 
> Theyre on master at v7.1-rc2
> 
> The "modules" intersection is on the re-composing of struct
> ddebug_info, which is a member in struct module, and maps a module's
> __dyndbg* elf sections.
> 
> The user visible change to /proc/dynamic_debug/control is s/class
> unknown/class:_UNKNOWN_/, which is a more visible/greppable indication
> of incomplete class definitions.
> 
> Coder visible change is to drop the enum ddebug_class_map_type's
> unused vals - namely: DD_CLASS_TYPE_DISJOINT_NAMES
> & DD_CLASS_TYPE_LEVEL_NAMES
> 
> These allowed more symbolic named inputs:
>   echo +DRM_UT_CORE > /sys/module/drm/parameters/debug
> 
> But theyre unused 3 years later, and probably not worth keeping.
> With a removal commit in the log, its easy enough to restore them later.

Thanks, Jim.

I'll queue this for some runtime testing in linux-next.  But AI review
really went to town over it:

	https://sashiko.dev/#/patchset/20260504-dd-cleanups-2-v1-0-6fdd24040642@gmail.com


