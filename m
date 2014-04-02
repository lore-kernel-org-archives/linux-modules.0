Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mail-yh0-f49.google.com ([209.85.213.49]:63712 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758049AbaDBIpR (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Wed, 2 Apr 2014 04:45:17 -0400
Received: by mail-yh0-f49.google.com with SMTP id z6so10142565yhz.8
        for <linux-modules@vger.kernel.org>; Wed, 02 Apr 2014 01:45:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140401111854.GK1123@intel.com>
References: <1396271931-7431-1-git-send-email-mmarek@suse.cz>
 <1396271931-7431-2-git-send-email-mmarek@suse.cz> <20140401111854.GK1123@intel.com>
From: Tom Gundersen <teg@jklm.no>
Date: Wed, 2 Apr 2014 10:44:56 +0200
Message-ID: <CAG-2HqVvLP-sBS12MmnTep19sSH6N1dL04wOK5z3noSb6zRStQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] config: also parse softdeps from modules
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Michal Marek <mmarek@suse.cz>,
	"linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

On Tue, Apr 1, 2014 at 1:18 PM, Lucas De Marchi
<lucas.demarchi@intel.com> wrote:
> Hi Michal and Tom.
>
>
> On Mon, Mar 31, 2014 at 03:18:51PM +0200, Michal Marek wrote:
>> From: Tom Gundersen <teg@jklm.no>
>>
>> This information can be found in /lib/modules/`uname -r`/modules.softdep, and
>> has only recently been exported by the kernel.
>>
>> Also remove the advice about copying modules.softdep to /lib/modules as it is
>> not clear how to do this correctly with several kernels installed with
>> potentially conflicting soft dependencies.
>> ---
>
> I think in most of the cases using a softdep from the kernel is wrong,
> since there are other better ways to do it. But there are some it's
> indeed difficult to avoid... crct10dif is one of them.
>
> Applied.

Thanks to both. I had forgotten about this.

Cheers,

Tom
