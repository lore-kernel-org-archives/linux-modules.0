Return-Path: <lucas.demarchi@intel.com>
Date: Fri, 4 Apr 2014 07:06:23 -0300
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Michal Marek <mmarek@suse.cz>
CC: Lucas De Marchi <lucas.de.marchi@gmail.com>, linux-modules
	<linux-modules@vger.kernel.org>
Subject: Re: [PATCH 1/3] testsuite: Do not run tests with *.ko.gz if zlib is
 not enabled
Message-ID: <20140404100622.GB29386@intel.com>
References: <1396603936-13045-1-git-send-email-mmarek@suse.cz>
 <CAKi4VAKqM9sC26=qkWJ6Mw=u9YrbyBa4JGSN=pK5T8NZzQUSdA@mail.gmail.com>
 <533E8272.8070102@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <533E8272.8070102@suse.cz>
Return-Path: lucas.demarchi@intel.com
List-ID: <linux-modules.vger.kernel.org>

On Fri, Apr 04, 2014 at 11:59:14AM +0200, Michal Marek wrote:
> On 2014-04-04 11:47, Lucas De Marchi wrote:
> > On Fri, Apr 4, 2014 at 6:32 AM, Michal Marek <mmarek@suse.cz> wrote:
> >> Unfortunately, all the depmod tests depend on zlib.
> > 
> > wouldn't it be better to decompress these files so we remove the dependencies?
> 
> I'm not against it. I thought the files were compressed so the the zlib
> support is tested. I can post a patch that decompresses them.


Some of the tests, yes... not all of them.  There's 1 specific test for
compressed modules. The others can be decompressed.

--
Lucas De Marchi
