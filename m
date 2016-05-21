MIME-Version: 1.0
In-Reply-To: <1460541612.2705.32.camel@decadent.org.uk>
References: <20160405001611.GJ21187@decadent.org.uk>
	<20160405003237.GK21187@decadent.org.uk>
	<CAKi4VAK64gR8U2n6=fO8o9Y1m7bTJsmeDLQcpegjF+57=_e8VA@mail.gmail.com>
	<1460541612.2705.32.camel@decadent.org.uk>
Date: Sat, 21 May 2016 15:31:53 -0300
Message-ID: <CAKi4VAKQecNsdVUXV0dR8_0GTKBirZq8NR7b32xMY+ar3Dn4Uw@mail.gmail.com>
Subject: Re: [PATCH v2] libkmod: Add support for detached module signatures
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: linux-modules <linux-modules@vger.kernel.org>, 820010@bugs.debian.org,
	Rusty Russell <rusty@rustcorp.com.au>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Wed, Apr 13, 2016 at 7:00 AM, Ben Hutchings <ben@decadent.org.uk> wrote:
> On Wed, 2016-04-13 at 01:05 -0300, Lucas De Marchi wrote:
>> Hi,
>>
>> CC'ing Rusty
>>
>> On Mon, Apr 4, 2016 at 9:32 PM, Ben Hutchings <ben@decadent.org.uk> wrote:
>> >
>> > Debian will not sign modules during the kernel package build, as this
>> > conflicts with the goal of reproducible builds.  Instead, we will
>> > generate detached signatures offline and include them in a second
>> > package.
>> Is this a decision already? It doesn't look as a good reason - you
>> would already need to provide a signing key (CONFIG_MODULE_SIG_KEY)
>> anyway for this to work. How is leaving the module signature in
>> another package be any better than just signing the module?  If you
>> have the signature, the build is just as reproducible as before.
>
> I think we may have different ideas about what reproducibility means.
> When I say reproducible I mean *anyone* with the right tools installed
> can reproduce the binary packages (.deb) from the source package (.dsc
> and tarballs).
>
> The signing key obviously isn't available to everyone, so the source
> package has to include detached signatures prepared outside of the

And how is this signature prepared?  Since it needs the compiled
module it would be a matter of changing the compiler, even minor
version, to invalidate the argument of reproducible build. It seems
very fragile to me.

> package build process.  But we can't put them in the linux source
> package, because that results in a dependency loop.
>
>> >
>> > We could attach the signatures when building this second package or at
>> > installation time, but that leads to duplication of all modules,
>> > either in the archive or on users' systems.
>> >
>> > To avoid this, add support to libkmod for concatenating modules with
>> > detached signatures (files with the '.sig' extension) at load time.
>> this has the drawback that finit_module() can't be used.
>
> So does module compression, but it's still a supported option.

This is easily fixed by teaching the kernel to handle the fd as a
compressed file. The kernel already has the routines to uncompress
them anyway. Supporting detached signatures means it can't be fixed
anymore since we will have to use init_module() rather than
finit_module().


Lucas De Marchi
