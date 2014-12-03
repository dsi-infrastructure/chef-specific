#
# Cookbook Name:: chef-specific.gov.pf
# Recipe:: default
#
# Copyright (C) 2014 PE, pf.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
package 'nano' do
 action :remove
end

confile = node['chef-specific.gov.pf']['squid3_confile']

bash "squidCookbookBug" do
  code "USER=$(echo $(grep -s '^[^#]*cache_effective_user' #{confile})| cut -d' ' -f2); DIR=$(echo $(grep -s '^[^#]*cache_dir' #{confile})| cut -d' ' -f3); [ ! -z \"$USER\" ] && [ ! -z \"$DIR\" ] && chown -R $USER $DIR"
  only_if do ::File.exists?( confile ) end
end

bash "apt-cacher-ng" do
  code "chown -R apt-cacher-ng: /var/cache/apt-cacher-ng"
  only_if do ::File.exists?( "/var/cache/apt-cacher-ng" ) end
end

