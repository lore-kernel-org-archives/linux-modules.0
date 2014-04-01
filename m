Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:47027 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751423AbaDALS7 (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Tue, 1 Apr 2014 07:18:59 -0400
Date: Tue, 1 Apr 2014 08:18:54 -0300
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Michal Marek <mmarek@suse.cz>
CC: <linux-modules@vger.kernel.org>, Tom Gundersen <teg@jklm.no>
Subject: Re: [PATCH 2/2] config: also parse softdeps from modules
Message-ID: <20140401111854.GK1123@intel.com>
References: <1396271931-7431-1-git-send-email-mmarek@suse.cz>
 <1396271931-7431-2-git-send-email-mmarek@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1396271931-7431-2-git-send-email-mmarek@suse.cz>
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Hi Michal and Tom.


On Mon, Mar 31, 2014 at 03:18:51PM +0200, Michal Marek wrote:
> From: Tom Gundersen <teg@jklm.no>
> 
> This information can be found in /lib/modules/`uname -r`/modules.softdep, and
> has only recently been exported by the kernel.
> 
> Also remove the advice about copying modules.softdep to /lib/modules as it is
> not clear how to do this correctly with several kernels installed with
> potentially conflicting soft dependencies.
> ---

I think in most of the cases using a softdep from the kernel is wrong,
since there are other better ways to do it. But there are some it's
indeed difficult to avoid... crct10dif is one of them.

Applied.

-- 
Lucas De Marchi
