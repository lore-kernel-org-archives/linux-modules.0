Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481211D516F;
	Mon, 28 Jul 2025 14:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753713264; cv=none; b=SbgAVgiEtG6QoEODNAvoEOfKWf0hnVcXh8vEra9VIctlO4rSShYjO+TlonY1IJpcjnTmSWlf0q66vRvrMHXEGz4hdu4MDdQLroRVOqgdmoDVHP7+0KJaz1kc50hF7wThXrWXhH1M4mOD7WPMlGXi2lj50flseX9VZk3au0JrV/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753713264; c=relaxed/simple;
	bh=lh/48q/oMGiBcZSaYVTRontq45ufEmD50w2YxneuUDk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eaJJReEfZY73gFbAnUuqdpW64BiJ+9XjtpKHSlrZaCf/oNI1N41oUo37M2yOUTu3hb6No56xBrVZ4k8gwDMrGOlARrNiiM3LGyx2q8j4YKMO63oDYAmstk8q3VLle3o4OeZaXJ06fQZ4g17oElcVEOV8hTEbZd/ciuK3l+h/AEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 80C6B1602E9;
	Mon, 28 Jul 2025 14:34:13 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id 57F0920011;
	Mon, 28 Jul 2025 14:34:11 +0000 (UTC)
Date: Mon, 28 Jul 2025 10:34:10 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Daniel Gomez <da.gomez@kernel.org>
Cc: Petr Pavlu <petr.pavlu@suse.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] tracing: Replace MAX_PARAM_PREFIX_LEN with
 MODULE_NAME_LEN
Message-ID: <20250728103410.26855bc2@batman.local.home>
In-Reply-To: <e9caf91d-3a4b-4140-a3bc-0c2b53c0a220@kernel.org>
References: <20250630143535.267745-1-petr.pavlu@suse.com>
	<20250630143535.267745-5-petr.pavlu@suse.com>
	<e9caf91d-3a4b-4140-a3bc-0c2b53c0a220@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 4tnwjdobfcdz5i4q6kcm9ir7g6e15mfc
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 57F0920011
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/YFjT/tw8agFjqT7o0o/dqdKu+CmFhqB0=
X-HE-Tag: 1753713251-187602
X-HE-Meta: U2FsdGVkX1/KQOCirvTx4EZX1xv9RUzQuFfctc5lM8XbiBVexf/kMNh/FNAO2Qly4cDVtt0a6uch4bhoEjlxajIqhsZVlX8XrNIMga4q3ge7CPi7cjrQs+LRKX6/oRaEg7YaBnb0XNtMRzmOkhfmCsaJUsL5X1PMgzRUrt4+2A/PLXLB/AUnyTFa/R2D8Mgi7I08bdMMxicv6nI7LfIb99r6AEyxWenqGCYyE/2cGK0cqAB2FfTWgespg/1i4yriecj5Tkg0BnYBSX2SPRyPN0pXREqjnmAXK3hroZh3+YJQx2mSiLYivsHJQ9zC/VafrQ8WKNuMDpL86tYzF8qjD+ztwub5gGdSpu95aKnX5CTrvX4S5DAYPzFBByXIM9hpVFN8j9MTNpjGEMTZhwhfuuVCNlGa7s+iHoFslgunuaYC7ReAtxwBxSb52TDl3VYvOjv2Wdlu5d2FcYuBfblAvA==

On Mon, 28 Jul 2025 08:48:01 +0200
Daniel Gomez <da.gomez@kernel.org> wrote:

> On 30/06/2025 16.32, Petr Pavlu wrote:
> > Use the MODULE_NAME_LEN definition in module_exists() to obtain the maximum
> > size of a module name, instead of using MAX_PARAM_PREFIX_LEN. The values
> > are the same but MODULE_NAME_LEN is more appropriate in this context.
> > MAX_PARAM_PREFIX_LEN was added in commit 730b69d22525 ("module: check
> > kernel param length at compile time, not runtime") only to break a circular
> > dependency between module.h and moduleparam.h, and should mostly be limited
> > to use in moduleparam.h.
> > 
> > Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>  
> 
> Steven, Masami,
> 
> I'm planning to merge these series into modules-next. I think and Ack/Review
> would be great from you. Otherwise, let me know if you'd rather take this patch
> through tracing instead (in case it looks good from your side).

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

> 
> > ---
> > 
> > As a side note, I suspect the function module_exists() would be better
> > replaced with !!find_module() + RCU locking, but that is a separate issue.

Yeah, that is probably something that should be done too.

Thanks,

-- Steve

